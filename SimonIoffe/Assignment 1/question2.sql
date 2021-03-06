
SELECT awardid,[POS] ,count(*)   as Count 
  FROM [baseball].[dbo].[fielding] a
  left join [baseball].[dbo].[awardsplayers] b
  on a.playerID=b.playerid
  and a.yearID=b.yearid
  WHERE awardid in ('Triple Crown', 'MVP')
  group by awardid  ,[POS]
  order by awardid, count(*) desc

