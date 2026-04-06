CREATE TABLE file (
                      id BIGINT NOT NULL AUTO_INCREMENT,
                      card_id BIGINT NOT NULL,
                      upload_file_name VARCHAR(255) NOT NULL,
                      original_filename VARCHAR(255) NOT NULL,
                      file_url VARCHAR(255) NOT NULL,
                      file_path VARCHAR(255) NOT NULL,
                      file_type VARCHAR(50) NOT NULL,
                      file_size BIGINT NOT NULL,
                      PRIMARY KEY (id)
);

-- 외래 키 제약 조건 추가
ALTER TABLE file
    ADD CONSTRAINT FK_file_card FOREIGN KEY (card_id) REFERENCES card (id);