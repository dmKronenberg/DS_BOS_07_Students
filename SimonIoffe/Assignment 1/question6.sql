SELECT distinct
a.name
,coalesce(d.count,0) as World_Series_Titles
,coalesce(c.count,0) as Divion_Titles
,coalesce(b.count,0) as League_Championships  
 FROM														----GET THE MOST RECENT TEAM NAME
		 (SELECT name, teamid FROM(   
			SELECT name, teamid, ROW_NUMBER() OVER(PARTITION BY teamid ORDER BY yearid DESC) AS Row
			FROM [baseball].[dbo].[teams] a
		 )a where row=1
		 ) a
 left join 
			 (
			SELECT [teamID]
			  ,count(*) as count
			   FROM [baseball].[dbo].[teams]
			   where coalesce(divwin,cast(rank as varchar(8))) in ('1','Y') 
				group by   [teamID]
			)  b
on a.teamID=b.teamID
left join
			(  SELECT 
				  [teamIDwinner]
				  , 'Divison' as title
				  , count(*) as count
			  FROM [baseball].[dbo].[seriespost]
				where round in ('NLCS','ALCS')
			  group by [teamIDwinner]
			) c
on c.teamIDwinner=a.teamID
left join 
			(  SELECT 
				  [teamIDwinner]
				  , 'World Series' as title
				  , count(*) as count
			  FROM [baseball].[dbo].[seriespost]
			  where round ='WS'
			  group by [teamIDwinner]
			  ) d
on d.teamIDwinner=a.teamID
order by coalesce(d.count,0) desc,coalesce(c.count,0) desc,coalesce(b.count,0) desc