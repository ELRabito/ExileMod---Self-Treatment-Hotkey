/**
* ExileClient_system_util_QuickSelfTreat 
* V0.21
* by El*Rabito
*/
private _playerObject = player;
if ((!alive _playerObject) || ExileClientInventoryOpened || ExileClientIsAutoRunning || ExileIsPlayingRussianRoulette || ExileClientIsHandcuffed) exitWith {};
if (animationState _playerObject in ["unconscious","unconsciousoutprone","ainvpknlmstpslaywnondnon_medic","ainvpknlmstpslaywpstdnon_medic","ainvpknlmstpslaywrfldnon_medic","ainvppnemstpslaywnondnon_medic","ainvppnemstpslaywrfldnon_medic","AmovPercMstpSsurWnonDnon"]) exitWith {};
if (animationState _playerObject select [1,3] in ["bdv","bsw","dve","sdv","ssw","swm"]) exitWith {};
private _minHkHDamage = getNumber(missionConfigFile >> "CfgRWSelfTreat" >> "minHkHDamage");
if (((damage _playerObject)*100) < _minHkHDamage) exitWith {};
private _AllLightMeds = getArray(missionConfigFile >> "CfgRWSelfTreat" >> "LightMeds");
private _AllMidMeds = getArray(missionConfigFile >> "CfgRWSelfTreat" >> "MidMeds");
private _AllStrongMeds = getArray(missionConfigFile >> "CfgRWSelfTreat" >> "StrongMeds");
private _AllPlayerMeds = ((magazinecargo (uniformContainer _playerObject)) + (magazinecargo (VestContainer _playerObject)));
private _PLightMeds = [];
private _PMidMeds = [];
private _PStrongMeds = [];
private _PAllAvailabeMeds = [];
playSound3D ["a3\sounds_f\characters\stances\binoculars_to_unarmed.wss", vehicle player, false, getPosASL player, 5, 1, 10,0,false];
{
	if (_x in _AllPlayerMeds) then
	{
		if(_x in _AllLightMeds) then {
			_PAllAvailabeMeds pushBack _x;
			_PLightMeds pushBack _x;
			continue
		};
		if(_x in _AllMidMeds) then {
			_PAllAvailabeMeds pushBack _x;
			_PMidMeds pushBack _x;
			continue
		};
		if(_x in _AllStrongMeds) then {
			_PAllAvailabeMeds pushBack _x;
			_PStrongMeds pushBack _x;
			continue
		};
	};
} forEach (_AllLightMeds + _AllMidMeds + _AllStrongMeds);
if (count _PAllAvailabeMeds < 1) exitWith {
	["ErrorTitleAndText", [format ["<img size='40' image='%1'/><t > Treatment Failed<br/>No medicine found in your Uniform or Vest!</t>","exile_assets\texture\ui\xm8_app_health_scanner_ca.paa"]]] call ExileClient_gui_toaster_addTemplateToast;
	playSound3D ["a3\ui_f\data\sound\cfgnotifications\scoreremoved.wss", vehicle player, false, getPosASL player, 10, 1, 10,0,true];
};
private _ExileClient_Treatment_Item = "";
private _CanTreat = false;
if (isbleeding _playerObject && (_PLightMeds isNotEqualTo [])) then {_ExileClient_Treatment_Item = _PLightMeds #0; _CanTreat = true};
if (!_CanTreat && {(damage _playerObject >= 0.05 && damage _playerObject <=0.20) && (_PLightMeds isNotEqualTo [])}) then {_ExileClient_Treatment_Item = _PLightMeds #0; _CanTreat = true}; 
if (!_CanTreat && {(damage _playerObject >= 0.20 && damage _playerObject <=0.50) && (_PMidMeds isNotEqualTo [])}) then {_ExileClient_Treatment_Item = _PMidMeds #0; _CanTreat = true}; 
if (!_CanTreat && {(damage _playerObject >= 0.50 && damage _playerObject <=0.99) && (_PStrongMeds isNotEqualTo [])}) then {_ExileClient_Treatment_Item = _PStrongMeds #0; _CanTreat = true};
if (_CanTreat) then {[_ExileClient_Treatment_Item] call ExileClient_object_item_consume} else {{if!(isNil "_x") exitWith {[_x] call ExileClient_object_item_consume}} forEach _PAllAvailabeMeds};                                                                                    
true
