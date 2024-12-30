package com.test.editor.handler;

import java.io.ByteArrayInputStream;
import java.nio.charset.StandardCharsets;
import java.sql.Blob;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;

public class BlobToStringTypeHandler extends BaseTypeHandler<String> {

    @Override
    public void setNonNullParameter(PreparedStatement ps, int i, String parameter, JdbcType jdbcType) throws SQLException {
        if (parameter == null) {
            ps.setNull(i, Types.BLOB);
        } else {
            byte[] bytes = parameter.getBytes(StandardCharsets.UTF_8);
            ps.setBlob(i, new ByteArrayInputStream(bytes));
        }
    }

    @Override
    public String getNullableResult(ResultSet rs, String columnName) throws SQLException {
        Blob blob = rs.getBlob(columnName);
        return (blob != null) ? new String(blob.getBytes(1, (int) blob.length()), StandardCharsets.UTF_8) : null;
    }

    @Override
    public String getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
        Blob blob = rs.getBlob(columnIndex);
        return (blob != null) ? new String(blob.getBytes(1, (int) blob.length()), StandardCharsets.UTF_8) : null;
    }

    @Override
    public String getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
        Blob blob = cs.getBlob(columnIndex);
        return (blob != null) ? new String(blob.getBytes(1, (int) blob.length()), StandardCharsets.UTF_8) : null;
    }
}
