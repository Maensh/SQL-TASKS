create table match_results (
  match_date       date,
  location         varchar2(20),
  home_team_name   varchar2(20),
  away_team_name   varchar2(20),
  home_team_points integer,
  away_team_points integer
);

insert into match_results values ( date'2018-01-01', 'Snowley', 'Underrated United', 'Terrible Town', 2, 0 );
insert into match_results values ( date'2018-01-01', 'Coldgate', 'Average Athletic', 'Champions City', 1, 4 );
insert into match_results values ( date'2018-02-01', 'Dorwall', 'Terrible Town', 'Average Athletic', 0, 1 );
insert into match_results values ( date'2018-03-01', 'Coldgate', 'Average Athletic', 'Underrated United', 3, 3 );
insert into match_results values ( date'2018-03-02', 'Newdell', 'Champions City', 'Terrible Town', 8, 0 );

commit;
/*
You can combine pivot and unpivot a single statement. The output from the first becomes the input to the second.

For example, say you want to produce a league table from the match results. 
For each team this will show the number of games they've won, drawn, and lost.

To do this, you need several steps:

First, compare the home and away team points to find out whether each won, lost or drew.

Then, to count up the number of outcomes for each team, you need one column with all the names. 
To do this, you need to unpivot home and away, giving single column of team names.

Finally, to get the league table, you need to pivot the number of wins, losses, and draws for each team.
*/

-------------------------------------------------------------------------
with rws as (
  select home_team_name, away_team_name, 
         case
           when home_team_points > away_team_points then 'WON'
           when home_team_points < away_team_points then 'LOST'
           else 'DRAW'
         end home_team_result,
         case
           when home_team_points < away_team_points then 'WON'
           when home_team_points > away_team_points then 'LOST'
           else 'DRAW'
         end away_team_result
  from   match_results
)
  select team, w, d, l 
  from   rws
  unpivot (
    ( team, result ) for home_or_away in ( 
      ( home_team_name, home_team_result ) as 'HOME', 
      ( away_team_name, away_team_result ) as 'AWAY'
    )
  )
  pivot (
    count (*), min ( home_or_away ) dummy
    for result in (
      'WON' W, 'DRAW' D, 'LOST' L
    )
  )
  order  by w desc, d desc, l;