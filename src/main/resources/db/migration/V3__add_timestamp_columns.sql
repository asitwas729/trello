-- file 테이블에 생성일, 수정일 컬럼 추가
ALTER TABLE file ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL;
ALTER TABLE file ADD COLUMN modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- H2에서 'ON UPDATE' 기능을 완벽히 지원하지 않을 수 있으므로, 
-- 가급적 애플리케이션(JPA @CreatedDate, @LastModifiedDate) 레벨에서 관리하는 것을 권장합니다.