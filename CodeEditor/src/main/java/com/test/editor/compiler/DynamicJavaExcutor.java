package com.test.editor.compiler;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;
import java.lang.reflect.Method;
import java.net.URI;
import java.net.URL;
import java.net.URLClassLoader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Collections;

import javax.tools.Diagnostic;
import javax.tools.DiagnosticCollector;
import javax.tools.JavaCompiler;
import javax.tools.JavaFileObject;
import javax.tools.SimpleJavaFileObject;
import javax.tools.StandardJavaFileManager;
import javax.tools.ToolProvider;

import org.springframework.stereotype.Component;

import com.test.editor.model.ExecuteCode;

@Component
public class DynamicJavaExcutor {

    public String execute(ExecuteCode code) {
        String className = code.getClassName();
        String javaCode = code.getCode();

        try {
            // 메모리 내 소스 코드 저장
            JavaFileObject file = new InMemoryJavaFileObject(className, javaCode);

            // Java Compiler API 설정
            JavaCompiler compiler = ToolProvider.getSystemJavaCompiler();
            DiagnosticCollector<JavaFileObject> diagnostics = new DiagnosticCollector<>();
            StandardJavaFileManager fileManager = compiler.getStandardFileManager(diagnostics, null, null);

            // 임시 디렉토리에 컴파일된 파일을 저장
            Path tempDir = Files.createTempDirectory("dynamic-classes");
            fileManager.setLocation(javax.tools.StandardLocation.CLASS_OUTPUT, Collections.singletonList(tempDir.toFile()));

            // 컴파일 작업 설정
            JavaCompiler.CompilationTask task = compiler.getTask(
                null,
                fileManager,
                diagnostics,
                null,
                null,
                Collections.singletonList(file)
            );

            // 컴파일 시도
            boolean success = task.call();
            fileManager.close();
            if (!success) {
                // 컴파일 실패 시 에러 메시지 반환
                StringBuilder errorMessages = new StringBuilder();
                for (Diagnostic<?> diagnostic : diagnostics.getDiagnostics()) {
                    errorMessages.append(diagnostic.getMessage(null)).append("\n");
                }
                return "Compilation failed:\n" + errorMessages.toString();
            }

            // 컴파일 성공 시 동적 클래스 로드 및 실행
            URLClassLoader classLoader = URLClassLoader.newInstance(new URL[]{tempDir.toUri().toURL()});
            Class<?> clazz = Class.forName(className, true, classLoader);
            Method mainMethod = clazz.getMethod("main", String[].class);

            // 실행 결과를 캡처
            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            PrintStream printStream = new PrintStream(outputStream);
            PrintStream oldOut = System.out;
            System.setOut(printStream);

            // 실행 시도
            mainMethod.invoke(null, (Object) new String[]{});

            // 실행 결과 반환
            System.setOut(oldOut);
            return outputStream.toString();

        } catch (Exception e) {
            return "Error during execution: " + e.getMessage();
        }
    }

    // In-memory representation of a Java source file
    static class InMemoryJavaFileObject extends SimpleJavaFileObject {
        private final String code;

        public InMemoryJavaFileObject(String className, String code) {
            super(URI.create("string:///" + className.replace('.', '/') + Kind.SOURCE.extension), Kind.SOURCE);
            this.code = code;
        }

        @Override
        public CharSequence getCharContent(boolean ignoreEncodingErrors) {
            return code;
        }
    }
}