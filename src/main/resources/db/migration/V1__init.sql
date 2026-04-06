-- 1. Workspace
CREATE TABLE workspace (
                           id BIGINT NOT NULL AUTO_INCREMENT,
                           title VARCHAR(255),
                           description VARCHAR(255),
                           created_at DATETIME(6),
                           modified_at DATETIME(6),
                           PRIMARY KEY (id)
);

-- 2. Users (H2에서 'user'는 예약어이므로 'users' 권장)
CREATE TABLE users (
                       id BIGINT NOT NULL AUTO_INCREMENT,
                       email VARCHAR(255),
                       password VARCHAR(255),
                       role VARCHAR(20), -- H2에서는 ENUM 대신 VARCHAR 후 애플리케이션에서 제어 권장
                       deleted BIT DEFAULT FALSE,
                       created_at DATETIME(6),
                       modified_at DATETIME(6),
                       PRIMARY KEY (id)
);

-- 3. Board
CREATE TABLE board (
                       id BIGINT NOT NULL AUTO_INCREMENT,
                       workspace_id BIGINT,
                       title VARCHAR(255),
                       background_color VARCHAR(255),
                       image_url VARCHAR(255),
                       PRIMARY KEY (id)
);

-- 4. Lists
CREATE TABLE lists (
                       id BIGINT NOT NULL AUTO_INCREMENT,
                       board_id BIGINT,
                       title VARCHAR(255),
                       order_number BIGINT,
                       created_at DATETIME(6),
                       modified_at DATETIME(6),
                       PRIMARY KEY (id)
);

-- 5. Card
CREATE TABLE card (
                      id BIGINT NOT NULL AUTO_INCREMENT,
                      list_id BIGINT NOT NULL,
                      title VARCHAR(20) NOT NULL,
                      contents VARCHAR(100),
                      file_url VARCHAR(255),
                      deadline DATETIME(6),
                      created_at DATETIME(6),
                      modified_at DATETIME(6),
                      PRIMARY KEY (id)
);

-- 6. Card User (작업자)
CREATE TABLE card_user (
                           id BIGINT NOT NULL AUTO_INCREMENT,
                           card_id BIGINT,
                           user_id BIGINT,
                           PRIMARY KEY (id)
);

-- 7. Comment
CREATE TABLE comment (
                         id BIGINT NOT NULL AUTO_INCREMENT,
                         card_id BIGINT NOT NULL,
                         user_id BIGINT NOT NULL,
                         content TEXT NOT NULL, -- CHARACTER SET 문법 제거 (H2는 기본 UTF-8)
                         created_at DATETIME(6),
                         modified_at DATETIME(6),
                         PRIMARY KEY (id)
);

-- 8. Workspace User
CREATE TABLE workspace_user (
                                id BIGINT NOT NULL AUTO_INCREMENT,
                                user_id BIGINT,
                                workspace_id BIGINT,
                                role VARCHAR(20), -- ENUM 대신 VARCHAR 사용
                                PRIMARY KEY (id)
);

-- 외래 키 설정 (참조 테이블명을 'users'로 통일)

ALTER TABLE board
    ADD CONSTRAINT FK_board_workspace FOREIGN KEY (workspace_id) REFERENCES workspace (id);

ALTER TABLE card
    ADD CONSTRAINT FK_card_list FOREIGN KEY (list_id) REFERENCES lists (id);

ALTER TABLE card_user
    ADD CONSTRAINT FK_card_user_card FOREIGN KEY (card_id) REFERENCES card (id);

ALTER TABLE card_user
    ADD CONSTRAINT FK_card_user_user FOREIGN KEY (user_id) REFERENCES users (id);

ALTER TABLE comment
    ADD CONSTRAINT FK_comment_card FOREIGN KEY (card_id) REFERENCES card (id);

ALTER TABLE comment
    ADD CONSTRAINT FK_comment_user FOREIGN KEY (user_id) REFERENCES users (id);

ALTER TABLE lists
    ADD CONSTRAINT FK_lists_board FOREIGN KEY (board_id) REFERENCES board (id);

ALTER TABLE workspace_user
    ADD CONSTRAINT FK_workspace_user_user FOREIGN KEY (user_id) REFERENCES users (id);

ALTER TABLE workspace_user
    ADD CONSTRAINT FK_workspace_user_workspace FOREIGN KEY (workspace_id) REFERENCES workspace (id);