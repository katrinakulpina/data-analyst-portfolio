create table demipt3.klpn_log (
	dt date,
	link varchar(50),
	user_agent varchar(200),
	region varchar(30)
);

insert into demipt3.klpn_log (dt, link, user_agent, region)
select 
	cast(dt as date),
	cast(link as varchar(50)),
	cast(user_agent as varchar(200)),
	cast(region as varchar(30))
from (
	select ip, dt, link, n1,
			trim(substr(data, 1, strpos(data, ' '))) as n2,
			trim(substr(data, strpos(data, ' '))) as user_agent
		from (
		select 
			ip,
			dt,
			link,
			trim(substr(data, 1, strpos(data, ' '))) as n1,
			trim(substr(data, strpos(data, ' '))) as data
		from (
			select 
				ip,
				dt,
				trim(substr(data, 1, strpos(data, ' '))) as link,
				trim(substr(data, strpos(data, ' '))) as data
			from (
				select 
					trim(substr(data, 1, strpos(data, ' '))) as ip,
					to_timestamp(trim(substr(data, strpos(data, ' ')+1, 14)), 'YYYYMMDDHH24MISS') as dt,
					trim(substr(data, strpos(data, ' ')+15)) as data
				from (
					select 
						regexp_replace(data, '\t+', ' ', 'g') as data
					from de.log
					where data is not null
				) t1
			) t2
		) t3
	) t4
) log left join (
	select
		trim(substr(data, 1, strpos(data, ' '))) as ip,
		trim(substr(data, strpos(data, ' '))) as region
	from (
		select
			regexp_replace(data, '\t', ' ') as data 
		from de.ip
	) t
) ip 
on log.ip = ip.ip;


create table demipt3.klpn_log_report (
	region varchar(30),
	browser varchar(10)
);

insert into demipt3.klpn_log_report (region, browser)
select 
	region,
	cast(browser as varchar(10))
from (
	with rep as (
		select 
			region,
			trim(substr(user_agent, 1, strpos(user_agent, '/')-1)) as browser,
			count(*) as cnt
		from demipt3.klpn_log
		group by region, trim(substr(user_agent, 1, strpos(user_agent, '/')-1))
	)
	select 
		region,
		min(browser) as browser
	from rep r
	where cnt = (select max(cnt) from rep r1 where r1.region = r.region)
	group by region
) report;










