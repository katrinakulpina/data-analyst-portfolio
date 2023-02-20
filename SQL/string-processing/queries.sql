-- Задание 1
CREATE TABLE log (
	dt DATE,
	link VARCHAR(50),
	user_agent VARCHAR(200),
	region VARCHAR(30)
);

INSERT INTO log (dt, link, user_agent, region)
SELECT 
	CAST(dt AS DATE),
	CAST(link AS VARCHAR(50)),
	CAST(user_agent AS VARCHAR(200)),
	CAST(region AS VARCHAR(30))
FROM (
	SELECT ip, dt, link, n1,
		TRIM(SUBSTR(data, 1, STRPOS(data, ' '))) AS n2,
		TRIM(SUBSTR(data, STRPOS(data, ' '))) AS user_agent
	FROM (
		SELECT ip, dt, link,
			TRIM(SUBSTR(data, 1, STRPOS(data, ' '))) AS n1,
			TRIM(SUBSTR(data, STRPOS(data, ' '))) AS data
		FROM (
			SELECT 
				ip,
				dt,
				TRIM(SUBSTR(data, 1, STRPOS(data, ' '))) AS link,
				TRIM(SUBSTR(data, STRPOS(data, ' '))) AS data
			FROM (
				SELECT 
					TRIM(SUBSTR(data, 1, STRPOS(data, ' '))) AS ip,
					TO_TIMESTAMP(TRIM(SUBSTR(data, STRPOS(data, ' ')+1, 14)), 'YYYYMMDDHH24MISS') AS dt,
					TRIM(SUBSTR(data, STRPOS(data, ' ')+15)) AS data
				FROM (
					SELECT 
						REGEXP_REPLACE(data, '\t+', ' ', 'g') AS data
					FROM de_log
					WHERE data IS NOT NULL
				) t1
			) t2
		) t3
	) t4
) l LEFT JOIN (
	SELECT
		TRIM(SUBSTR(data, 1, STRPOS(data, ' '))) AS ip,
		TRIM(SUBSTR(data, STRPOS(data, ' '))) AS region
	FROM (
		SELECT
			REGEXP_REPLACE(data, '\t', ' ') AS data 
		FROM de_ip
	) t
) ip 
ON l.ip = ip.ip;



-- Задание 2
CREATE TABLE log_report (
	region VARCHAR(30),
	browser VARCHAR(10)
);

INSERT INTO log_report (region, browser)
SELECT 
	region,
	CAST(browser AS VARCHAR(10))
FROM (
	WITH rep AS (
		SELECT 
			region,
			TRIM(SUBSTR(user_agent, 1, STRPOS(user_agent, '/')-1)) AS browser,
			COUNT(*) AS cnt
		FROM log
		GROUP BY region, TRIM(SUBSTR(user_agent, 1, STRPOS(user_agent, '/')-1))
	)
	SELECT 
		region,
		MIN(browser) AS browser
	FROM rep r
	WHERE cnt = (SELECT MAX(cnt) FROM rep r1 WHERE r1.region = r.region)
	GROUP BY region
) report;

