
drop sequence seqMember;
drop sequence seqTeam;
drop sequence seqProject;
drop sequence seqMemberTeam;
drop sequence seqTeamProject;
drop sequence seqCalendar;
drop sequence seqChatbot;
drop sequence seqTheme;
drop sequence seqStyleType;
drop sequence seqStyleSetting;
drop sequence seqBasicTemplate;
drop sequence seqTemplate;
drop sequence seqVersionInfo;
drop sequence seqFileType;
drop sequence seqVersionFile;
drop sequence seqBasicFile;
drop sequence seqServerList;
drop sequence seqTextChannel;
drop sequence seqTextContent;
drop sequence seqMemberServer;
drop sequence seqVoiceChannel;
drop sequence seqVoiceChannelSetting;

drop table voiceChannelSetting;
drop table  voiceChannel;
drop table  memberServer;
drop table  textContent;
drop table  textChannel;
drop table  serverList;
drop table  basicFile;
drop table  versionFile;
drop table  fileType;
drop table  versionInfo;
drop table  template;
drop table  basicTemplate;
drop table  styleSetting;
drop table  styleType;
drop table  theme;
drop table  chatbot;
drop table  calendar;
drop table  teamProject;
drop table  memberTeam;
drop table  project;
drop table  team;
drop table  member;


create sequence seqMember;

CREATE TABLE member (
	seq	number	primary key,
	id	varchar2(150) unique	NOT NULL,
	pw	varchar2(100)	NOT NULL,
	nick	varchar2(100) unique	NOT NULL,
	regdate	date	DEFAULT sysdate	NOT NULL,
	ing	number	DEFAULT 1	NOT NULL,
	color	number	DEFAULT 1	NOT NULL,
	oAuthType	number	DEFAULT 1	NOT NULL
);

create sequence seqTeam;

CREATE TABLE team (
	seq	number	primary key,
	teamName	varchar2(50)	NOT NULL,
	teamEx	varchar2(1000)	NULL,
	teamType	number	DEFAULT 2	NOT NULL,
	regdate	date	DEFAULT sysdate	NOT NULL
);

create sequence seqProject;

CREATE TABLE project (
	seq	number	primary key,
	projectName	varchar2(50)	NOT NULL,
	projectEx	varchar2(1000)	NULL,
	startDate	date	DEFAULT sysdate	NOT NULL,
	target	date	DEFAULT sysdate	NOT NULL,
	priority	number	DEFAULT 3	NOT NULL,
	regdate	date	DEFAULT sysdate	NOT NULL
);

create sequence seqMemberTeam;

CREATE TABLE memberTeam (
	seq	number	primary key,
	member_seq	number	NOT NULL,
	team_seq	number	NOT NULL,
	position	number	DEFAULT 2	NOT NULL,
    constraint fk_memberTeam_member foreign key(member_seq) references member(seq),
    constraint fk_memberTeam_team foreign key(team_seq) references team(seq)
);

create sequence seqTeamProject;

CREATE TABLE teamProject (
	seq number PRIMARY KEY, 
	team_seq number NOT NULL,
    project_seq number NOT NULL, 
    constraint fk_teamProject_team foreign key(team_seq) references team(seq),
    constraint fk_teamProject_project foreign key(project_seq) references project(seq)
);


create sequence seqCalendar;

CREATE TABLE calendar (
	seq	number	primary key,
	teamProject_seq	number	NOT NULL,
	startDate	date	DEFAULT sysdate	NOT NULL,
	target	date	NULL,
	priority	number	NULL,
	schedule	varchar2(100)	NOT NULL,
    constraint fk_calendar_teamProject foreign key(teamProject_seq) references teamProject(seq)
);

-- 챗봇 -----
create sequence seqChatbot;
-- drop sequence seqChatbot;
CREATE TABLE chatbot (
	seq	number	primary key,
	member_seq	number	NOT NULL,
	memberMsg	varchar2(2000)	NOT NULL,
	botMsg	varchar2(2000)	NOT NULL,
	chatDate	date	DEFAULT sysdate	NOT NULL,
    constraint fk_chatbot_member foreign key(member_seq) references member(seq)
);

-- 코드 편집기 -----
create sequence seqTheme;

CREATE TABLE theme (
	seq	number	NOT NULL,
	theme	number(1)	DEFAULT 0	NOT NULL,
	member_seq	number	NOT NULL,
    constraint fk_theme_member foreign key(member_seq) references member(seq)
);

create sequence seqStyleType;

CREATE TABLE styleType (
	seq	number	primary key,
	category	varchar2(50)	NOT NULL
);

create sequence seqStyleSetting;

CREATE TABLE styleSetting (
	seq	number	primary key,
	value	varchar2(100)	NOT NULL,
	member_seq	number	NOT NULL,
	styleType_seq	number	NOT NULL,
    constraint fk_styleSetting_member foreign key(member_seq) references member(seq),
    constraint fk_styleSetting_styleType foreign key(styleType_seq) references styleType(seq)
);

create sequence seqBasicTemplate;

CREATE TABLE basicTemplate (
	seq	number	NOT NULL,
	keyword	varchar2(100)	NOT NULL,
	code	varchar2(2000)	NOT NULL
);

create sequence seqTemplate;
-- drop sequence seqTemplate;
CREATE TABLE template (
	seq	number	primary key,
	keyword	varchar2(100)	NOT NULL,
	code	varchar2(2000)	NOT NULL,
	member_seq	number	NOT NULL,
    constraint fk_template_member foreign key(member_seq) references member(seq)
);

create sequence seqVersionInfo;

CREATE TABLE versionInfo (
	seq	number	primary key,
	regdate	date	DEFAULT sysdate	NOT NULL,
	message	varchar2(300)	NULL,
	project_seq	number	NOT NULL,
	member_seq	number	NOT NULL,
    constraint fk_versionInfo_project foreign key(project_seq) references project(seq),
    constraint fk_versionInfo_member foreign key(member_seq) references member(seq)
);

create sequence seqFileType;
-- drop sequence seqFileType;
CREATE TABLE fileType (
	seq	number	primary key,
	fileType	varchar2(100)	NOT NULL
);

create sequence seqVersionFile;

CREATE TABLE versionFile (
	seq	number	primary key,
	name	varchar2(600)	NOT NULL,
	code	blob	NULL,
	versionInfo_seq	number	NOT NULL,
	fileType_seq	number	NOT NULL,
	parent_seq	number	NULL,
    constraint fk_versionFile_versionInfo foreign key(versionInfo_seq) references versionInfo(seq),
    constraint fk_versionFile_fileType foreign key(fileType_seq) references fileType(seq),
    constraint fk_versionFile_parent foreign key(parent_seq) references versionFile(seq)
);

create sequence seqBasicFile;

CREATE TABLE basicFile (
	seq	number	primary key,
	name	varchar2(600)	NOT NULL,
	code	blob	NULL,
	fileType_seq	number	NOT NULL,
	parent_seq	number	NULL,
    constraint fk_basicFile_fileType foreign key(fileType_seq) references fileType(seq),
    constraint fk_basicFile_parent foreign key(parent_seq) references basicFile(seq)
);

-- 채팅 -----
create sequence seqServerList;

CREATE TABLE serverList (
	seq	number	primary key,
	serverName	varchar2(100)	NOT NULL,
	projectServerCheck	varchar2(1)	DEFAULT 'N'	NOT NULL
);

create sequence seqTextChannel;

CREATE TABLE textChannel (
	seq	number	primary key,
	textChannelName	varchar2(100)	DEFAULT '채팅채널1번' 	NULL,
	serverList_seq	number	NOT NULL,
    constraint fk_textchannel_serverList foreign key(serverList_seq) references serverList(seq)
);

create sequence seqTextContent;

CREATE TABLE textContent (
	seq	number	primary key,
	content	clob	NOT NULL,
	messageSentTime	date	NOT NULL,
	textChannel_seq	number	NOT NULL,
    constraint fk_textContent_textChannel foreign key(textChannel_seq) references textChannel(seq)
);

create sequence seqMemberServer;

CREATE TABLE memberServer (
	seq	number	primary key,
	serverList_seq	number	NOT NULL,
	member_seq	number	NOT NULL,
    constraint fk_memberServer_serverList foreign key(serverList_seq) references serverList(seq),
    constraint fk_memberServer_member foreign key(member_seq) references member(seq)
);

create sequence seqVoiceChannel;

CREATE TABLE voiceChannel (
	seq	number	primary key,
	voiceChannelName	varchar(100)	DEFAULT '음성채널1번' 	NULL,
	serverList_seq	number	NOT NULL,
    constraint fk_voiceChannel_serverList foreign key(serverList_seq) references serverList(seq)
);

create sequence seqVoiceChannelSetting;

CREATE TABLE voiceChannelSetting (
	seq	number	primary key,
	audioDevice	varchar2(1000)	DEFAULT '시스템 기본장치'	NULL,
	audioVolume	number	DEFAULT 50	NULL,
	recordingDevice	varchar2(1000)	DEFAULT '시스템 기본장치'	NULL,
	recordingVolume	number	DEFAULT 50	NULL,
	voiceChannel_seq	number	NOT NULL,
    constraint fk_voiceSetting_voiceChannel foreign key(voiceChannel_seq) references voiceChannel(seq)
);

CREATE OR REPLACE PROCEDURE insert_default_settings(p_member_seq NUMBER) AS
BEGIN

    INSERT INTO theme (seq, theme, member_seq) VALUES (seqTheme.nextVal, 0, p_member_seq);
    
    INSERT INTO styleSetting (seq, value, styleType_seq, member_seq) VALUES (seqStyleSetting.nextVal, '14', 1, p_member_seq);
    INSERT INTO styleSetting (seq, value, styleType_seq, member_seq) VALUES (seqStyleSetting.nextVal, 'Consolas', 2, p_member_seq);
    INSERT INTO styleSetting (seq, value, styleType_seq, member_seq) VALUES (seqStyleSetting.nextVal, '#1E1E1E', 3, p_member_seq); 
    INSERT INTO styleSetting (seq, value, styleType_seq, member_seq) VALUES (seqStyleSetting.nextVal, '#D4D4D4', 4, p_member_seq);   
    INSERT INTO styleSetting (seq, value, styleType_seq, member_seq) VALUES (seqStyleSetting.nextVal, '#608B4E', 5, p_member_seq); 
    INSERT INTO styleSetting (seq, value, styleType_seq, member_seq) VALUES (seqStyleSetting.nextVal, '#569CD6', 6, p_member_seq); 
    INSERT INTO styleSetting (seq, value, styleType_seq, member_seq) VALUES (seqStyleSetting.nextVal, '#CE9178', 7, p_member_seq); 
    
    
    INSERT INTO template (seq, member_seq, keyword, code) VALUES (seqTemplate.nextVal, p_member_seq, 'sysout', 'System.out.println(${1});${0}');    
    INSERT INTO template (seq, member_seq, keyword, code) VALUES (seqTemplate.nextVal, p_member_seq, 'trycatch', 'try {\n    ${1}\n} catch (${2:Exception} ${3:e}) {\n    ${4}\n}${0}');    
    INSERT INTO template (seq, member_seq, keyword, code) VALUES (seqTemplate.nextVal, p_member_seq, 'tryfinally', 'try {\n    ${1}\n} finally {\n    ${2}\n}${0}');    
    INSERT INTO template (seq, member_seq, keyword, code) VALUES (seqTemplate.nextVal, p_member_seq, 'main', 'public static void main(String[] args) {\n    ${0}\n}');    
    INSERT INTO template (seq, member_seq, keyword, code) VALUES (seqTemplate.nextVal, p_member_seq, 'if', 'if (${1:condition}) {\n    ${2}\n}${0}');    
    INSERT INTO template (seq, member_seq, keyword, code) VALUES (seqTemplate.nextVal, p_member_seq, 'else', 'else {\n    ${1}\n}${0}');    
    INSERT INTO template (seq, member_seq, keyword, code) VALUES (seqTemplate.nextVal, p_member_seq, 'catch', 'catch (${1:Exception} ${2:e}) {\n    ${3}\n}${0}');    
    INSERT INTO template (seq, member_seq, keyword, code) VALUES (seqTemplate.nextVal, p_member_seq, 'finally', 'finally {\n    ${1}\n}${0}');    
    INSERT INTO template (seq, member_seq, keyword, code) VALUES (seqTemplate.nextVal, p_member_seq, 'switch', 'switch (${1:key}) {\n    case ${2:value}:\n        ${0}\n        break;\n    default:\n        break;\n}');    
    INSERT INTO template (seq, member_seq, keyword, code) VALUES (seqTemplate.nextVal, p_member_seq, 'while', 'while (${1:condition}) {\n    ${2}\n}${0}');    
    INSERT INTO template (seq, member_seq, keyword, code) VALUES (seqTemplate.nextVal, p_member_seq, 'dowhile', 'do {\n    ${0}\n} while (${1:condition});');    
    INSERT INTO template (seq, member_seq, keyword, code) VALUES (seqTemplate.nextVal, p_member_seq, 'for', 'for (int ${1:index} = 0; ${1:index} < ${2:array}.length; ${1:index}++) {\n    ${3}\n}${0}');    
    INSERT INTO template (seq, member_seq, keyword, code) VALUES (seqTemplate.nextVal, p_member_seq, 'foreach', 'for (${1:Type} ${2:item} : ${3:collection}) {\n    ${0}\n}');    
    INSERT INTO template (seq, member_seq, keyword, code) VALUES (seqTemplate.nextVal, p_member_seq, 'syserr', 'System.err.println(${1});${0}');    
    INSERT INTO template (seq, member_seq, keyword, code) VALUES (seqTemplate.nextVal, p_member_seq, 'ifelse', 'if (${1:condition}) {\n    ${2}\n} else {\n    ${2}\n}${0}');    
    INSERT INTO template (seq, member_seq, keyword, code) VALUES (seqTemplate.nextVal, p_member_seq, 'ifelseif', 'if (${1:condition}) {\n    ${2}\n} else if (${3:condition}) {\n    ${4}\n} else {\n    ${5}\n}${0}');
    
END;
/

CREATE OR REPLACE PROCEDURE switchTheme(
    theme IN NUMBER,
    member_seq IN NUMBER
)
AS
BEGIN
    IF theme = 1 THEN
        -- 전환: 다크 모드에서 라이트 모드
        UPDATE styleSetting SET value = '#FFFFFF' WHERE styleType_seq = 3 AND member_seq = member_seq;
        UPDATE styleSetting SET value = '#000000' WHERE styleType_seq = 4 AND member_seq = member_seq;
        UPDATE styleSetting SET value = '#3A7F25' WHERE styleType_seq = 5 AND member_seq = member_seq;
        UPDATE styleSetting SET value = '#001EF5' WHERE styleType_seq = 6 AND member_seq = member_seq;
        UPDATE styleSetting SET value = '#96261F' WHERE styleType_seq = 7 AND member_seq = member_seq;
    ELSIF theme = 0 THEN
        -- 전환: 라이트 모드에서 다크 모드
        UPDATE styleSetting SET value = '#1E1E1E' WHERE styleType_seq = 3 AND member_seq = member_seq;
        UPDATE styleSetting SET value = '#D4D4D4' WHERE styleType_seq = 4 AND member_seq = member_seq;
        UPDATE styleSetting SET value = '#608B4E' WHERE styleType_seq = 5 AND member_seq = member_seq;
        UPDATE styleSetting SET value = '#569CD6' WHERE styleType_seq = 6 AND member_seq = member_seq;
        UPDATE styleSetting SET value = '#CE9178' WHERE styleType_seq = 7 AND member_seq = member_seq;
    END IF;
END switchTheme;
/

insert into fileType (seq, fileType) values (seqFileType.nextVal, 'Project');   -- 1
insert into fileType (seq, fileType) values (seqFileType.nextVal, 'Folder');    -- 2
insert into fileType (seq, fileType) values (seqFileType.nextVal, 'Package');   -- 3
insert into fileType (seq, fileType) values (seqFileType.nextVal, 'Class');     -- 4
insert into fileType (seq, fileType) values (seqFileType.nextVal, 'Interface'); -- 5
insert into fileType (seq, fileType) values (seqFileType.nextVal, 'TextFile');  -- 6
insert into fileType (seq, fileType) values (seqFileType.nextVal, 'File');      -- 7

INSERT INTO basicFile (seq, name, code, fileType_seq, parent_seq) VALUES (seqBasicFile.nextVal, 'TestProject', null, 1, null);
INSERT INTO basicFile (seq, name, code, fileType_seq, parent_seq) VALUES (seqBasicFile.nextVal, 'src', null, 2, 1);
INSERT INTO basicFile (seq, name, code, fileType_seq, parent_seq) VALUES (seqBasicFile.nextVal, 'com.test.main', null, 3, 2);
INSERT INTO basicFile (seq, name, code, fileType_seq, parent_seq) VALUES (seqBasicFile.nextVal, 'Test.java', UTL_RAW.CAST_TO_RAW('public class Test {\n    public static void main(String[] args) {\n        System.out.println("test");\n    }\n}'), 4, 3);
INSERT INTO basicFile (seq, name, code, fileType_seq, parent_seq) VALUES (seqBasicFile.nextVal, 'Inter.java', UTL_RAW.CAST_TO_RAW('public interface Inter {\n\n}'), 5, 3);
INSERT INTO basicFile (seq, name, code, fileType_seq, parent_seq) VALUES (seqBasicFile.nextVal, 'file.txt', null, 6, 3);
INSERT INTO basicFile (seq, name, code, fileType_seq, parent_seq) VALUES (seqBasicFile.nextVal, 'file', null, 7, 3);

INSERT INTO styleType (seq, category) VALUES (seqStyleType.nextVal, 'fontSize');
INSERT INTO styleType (seq, category) VALUES (seqStyleType.nextVal, 'fontFamily');
INSERT INTO styleType (seq, category) VALUES (seqStyleType.nextVal, 'editor.background');
INSERT INTO styleType (seq, category) VALUES (seqStyleType.nextVal, 'editor.foreground');  
INSERT INTO styleType (seq, category) VALUES (seqStyleType.nextVal, 'java.comment');
INSERT INTO styleType (seq, category) VALUES (seqStyleType.nextVal, 'java.keyword');
INSERT INTO styleType (seq, category) VALUES (seqStyleType.nextVal, 'java.String');

commit;