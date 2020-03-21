/*-----1308. Running Total for Different Genders-----*/
/*Write an SQL query to find the total score for each gender at each day.
  Order the result table by gender and day*/
select a1.gender, a1.day, sum(a2.eachday_total) as total
from (select gender, day, sum(score_points) as eachday_total
from Scores
group by gender, day
order by gender, day) as a1
,
(select gender, day, sum(score_points) as eachday_total
from Scores
group by gender, day
order by gender, day) as a2
where a1.gender = a2.gender and a1.day >= a2.day 
group by a1.gender, a1.day
order by a1.gender, a1.day
;

["gender", "day", "eachday_total"],
["F", "2019-12-30", 17], 
["F", "2019-12-31", 23],
["F", "2020-01-01", 17],
["F", "2020-01-07", 23],
["M", "2019-12-18", 2], 
["M", "2019-12-25", 11], 
["M", "2019-12-30", 13],
["M", "2019-12-31", 3], 
["M", "2020-01-07", 7]


["gender", "day", "eachday_total", "gender", "day", "eachday_total"], 
["F", "2019-12-30", 17,            "F", "2019-12-30", 17],
["F", "2019-12-31", 23,            "F", "2019-12-30", 17], 
["F", "2020-01-01", 17,            "F", "2019-12-30", 17], 
["F", "2020-01-07", 23,            "F", "2019-12-30", 17], 
["M", "2019-12-18", 2,             "M", "2019-12-18", 2],
["M", "2019-12-25", 11,            "M", "2019-12-18", 2], 
["M", "2019-12-30", 13,            "M", "2019-12-18", 2], 
["M", "2019-12-31", 3,             "M", "2019-12-18", 2], 
["M", "2020-01-07", 7,             "M", "2019-12-18", 2]

/*gender and day is primary key
so you don't need to build up table a*/
select a.gender, a.day,
sum(b.score_points) as total
from Scores a
left join Scores b on a.day >= b.day and a.gender = b.gender
group by a.gender, a.day
order by a.gender, a.day
;

["player_name", "gender", "day", "score_points", "player_name", "gender", "day", "score_points"]
["Priyanka",    "F",   "2019-12-30", 17,         "Priyanka",     "F",  "2019-12-30", 17],
["Priya",       "F",   "2019-12-31", 23,         "Priya",        "F",  "2019-12-31", 23], 
["Aron",        "F",   "2020-01-01", 17,         "Aron",         "F",  "2020-01-01", 17],
["Alice",       "F",   "2020-01-07", 23,         "Aron",         "F",  "2020-01-01", 17], 
["Jose",        "M",   "2019-12-18", 2,          "Jose",         "M",  "2019-12-18", 2], 
["Khali",       "M",   "2019-12-25", 11,         "Khali",        "M",  "2019-12-25", 11], 
["Slaman",      "M",   "2019-12-30", 13,         "Khali",        "M",  "2019-12-25", 11], 
["Joe",         "M",   "2019-12-31", 3,          "Khali",        "M",  "2019-12-25", 11],
["Bajrang",     "M",   "2020-01-07", 7,          "Bajrang",      "M",  "2020-01-07", 7]
