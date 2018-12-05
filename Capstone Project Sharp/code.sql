select distinct utm_campaign from page_visits group by utm_campaign;
select distinct utm_source from page_visits group by utm_source;
select distinct page_name from page_visits group by page_name;

WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT count(ft.user_id),
    ft.first_touch_at,
    pv.utm_source,
		pv.utm_campaign
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
    group by pv.utm_campaign;

WITH last_touch AS (
    SELECT user_id,
        max(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT count(ft.user_id),
    ft.last_touch_at,
    pv.utm_source,
		pv.utm_campaign
FROM last_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.last_touch_at = pv.timestamp
    group by pv.utm_campaign;

select count(distinct user_id), page_name from page_visits where page_name like '4%';
select count(distinct user_id), page_name from page_visits group by page_name;

WITH last_touch AS (
    SELECT user_id,
        max(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT count(ft.user_id),
    ft.last_touch_at,
    pv.utm_source,
		pv.utm_campaign,
    pv.page_name
FROM last_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.last_touch_at = pv.timestamp
    where pv.page_name like '4%'
    group by pv.utm_campaign;


