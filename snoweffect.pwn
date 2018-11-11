//snowing effect by vennox 10 nov 2k18

#include <a_samp>
#include <zcmd>
#include <foreach>

#define MAX_FLAKES	200		//nr maxim de fulgi de zapada care pot fi pe ecranul unui player in acelasi timp
#define FLAKES_UPDATE	500		//la cate ms sa se deplaseze fulgii gen
#define FLAKES_SPEED	10		//cu cate unitati sa se deplaseze fiecare fulg la delay-ul stabilit

new Text:snowflake[MAX_FLAKES], Float:flakepos[MAX_FLAKES][2], flakeson[MAX_PLAYERS];
public OnFilterScriptInit(){
	for(new i; i < MAX_FLAKES; i++){
		flakepos[i][0] = random(640);
		flakepos[i][1] = random(480);
		snowflake[i] = TextDrawCreate(flakepos[i][0], flakepos[i][1], ".");
		TextDrawLetterSize(snowflake[i], 0.400000, 1.600000);
		TextDrawAlignment(snowflake[i], 1);
		TextDrawColor(snowflake[i], -1);
		TextDrawSetShadow(snowflake[i], 0);
		TextDrawSetOutline(snowflake[i], 0);
		TextDrawBackgroundColor(snowflake[i], 255);
		TextDrawFont(snowflake[i], 1);
		TextDrawSetProportional(snowflake[i], 1);
		TextDrawSetShadow(snowflake[i], 0);
	}
	SetTimer("UpdateFlakes", FLAKES_UPDATE, 1);
	return 1;
}
forward UpdateFlakes();
public UpdateFlakes(){
	for(new i; i < MAX_FLAKES; i++){
		flakepos[i][1] += FLAKES_SPEED;
		if(flakepos[i][1] >= 480){
			flakepos[i][0] = random(640);
			flakepos[i][1] = -random(20);
		}
		TextDrawDestroy(snowflake[i]);
		snowflake[i] = TextDrawCreate(flakepos[i][0], flakepos[i][1], ".");
		TextDrawLetterSize(snowflake[i], 0.400000, 1.600000);
		TextDrawAlignment(snowflake[i], 1);
		TextDrawColor(snowflake[i], -1);
		TextDrawSetShadow(snowflake[i], 0);
		TextDrawSetOutline(snowflake[i], 0);
		TextDrawBackgroundColor(snowflake[i], 255);
		TextDrawFont(snowflake[i], 1);
		TextDrawSetProportional(snowflake[i], 1);
		TextDrawSetShadow(snowflake[i], 0);
	}
	foreach(new z:Player){
		if(flakeson[z]) for(new i; i < MAX_FLAKES; i++) TextDrawShowForPlayer(z, snowflake[i]);
	}
}
CMD:showflakes(playerid){
	for(new i; i < MAX_FLAKES; i++) TextDrawShowForPlayer(playerid, snowflake[i]);
	flakeson[playerid] = 1;
	return 1;
}
CMD:hideflakes(playerid){
	for(new i; i < MAX_FLAKES; i++) TextDrawHideForPlayer(playerid, snowflake[i]);
	flakeson[playerid] = 0;
	return 1;
}
public OnPlayerConnect(playerid){
	flakeson[playerid] = 1;
	return 1;
}
