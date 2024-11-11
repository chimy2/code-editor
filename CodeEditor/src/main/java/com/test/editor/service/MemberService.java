package com.test.editor.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.editor.dao.MemberDAO;
import com.test.editor.model.MemberDTO;

import java.util.List;

@Service
public class MemberService {

    @Autowired
    private MemberDAO dao;

    // MemberDAO의 username() 메서드를 호출하는 서비스 메서드 추가
    public List<MemberDTO> getUsernames() {
        return dao.username();
    }

    // 필요한 다른 DAO 메서드도 추가할 수 있습니다.
}
