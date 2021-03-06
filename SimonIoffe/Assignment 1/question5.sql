SELECT c.nameFirst, c.nameLast, count(distinct a.yearID) as Gold_Gloves, count(distinct b.yearID) as MVPs
  FROM [baseball].[dbo].[awardsplayers] a
  join [baseball].[dbo].[awardsplayers] b
  on a.playerID=b.playerID
  join [baseball].[dbo].[master] c
  on c.playerID=a.playerID
  WHERE a.awardid in ('Gold Glove') and b.awardid in ('MVP')
  GROUP BY a.playerID, c.nameFirst, c.nameLast
  order by MVPs desc, Gold_Gloves desc