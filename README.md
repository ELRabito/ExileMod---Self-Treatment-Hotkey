On button press the character will use a appropriate medicine depending on the severity of the damage.
If no appropriate medicine was found the script will use any available med the player has inside Uniform or Vest.
Checks for basic exploits/bugs already in place (Animation skipping, using it while swimming etc).
Sound effect to mimic the sound of searching for a appropriate medicine, error toast with information and sound clue if no medicine was found in the vest or uniform.

Code examples for putting it on a normal number row key like 8 or custom user action included (Optional or use them both). 


Donwload ExileClient_system_util_QuickSelfTreat and Define the new function (easily done via initplayerlocal.sqf for example like below) (Adjust pathes to your likings)

	private ['_code', '_function', '_file'];
	{
		_code = '';
		_function = _x select 0;
		_file = _x select 1;
		_code = compileScript [_file];
		missionNamespace setVariable [_function, _code];
	}
	forEach
	[
		["ExileClient_system_util_QuickSelfTreat","custom\SelfTreat\ExileClient_system_util_QuickSelfTreat.sqf"]
	];


Add this to config.cpp of your missionfile and adjust to settings/classnames to your likings.

	class CfgRWSelfTreat
	{
		// Minimum damage in percent for the hotkey self treatment to react.
		minHkHDamage = 10;
		
		// Add the classnames of the meds for each severity/damage level array, so the script will pick a appropriate one.
		// If no appropriate med was found the script will use any available med the player has inside Uniform or Vest.
		// 5 -> 20% damge
		LightMeds[] =
		{
			"Exile_Item_Bandage"
		};
		// 20 -> 50% damge
		MidMeds[] =
		{
			"Exile_Item_Vishpirin"
		};
		// 50 -> 99% damge
		StrongMeds[] =
		{
			"Exile_Item_InstaDoc"
		};
	};
