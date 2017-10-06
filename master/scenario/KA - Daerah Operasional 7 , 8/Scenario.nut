map.file = "RailfansDAOP7-8.sve"

scenario.short_description = "Kereta Api - Daerah Operasional 7 - 9 ( BETA )"
scenario.author = "Rengga Prakoso ( vzrenggamani )"
scenario.version = "0.3"
scenario.translation = "Satria Naa'il Kayana Ritonga"

function get_info_text(pl)
{
    function get_map_file()
{
	return map.file;
}
    function get_api_version()
{
	return ("api" in scenario) ? scenario.api : "112.3"
}
function get_about_text(pl)
{
	return "<em>Scenario:</em>  " +  scenario.short_description
	+ "<br><br><em>Author:</em> " +  scenario.author
	+ "<br><br><em>Version:</em> " +  scenario.version
	+ "<br><br><em>Translation:</em> " +  scenario.translation
}
}

function get_rule_text(pl)
{
    return @"Gaada Peraturan. Main Sesuka Hati, Bebas, Terserah. Cuma Satu No Cheat!!"
}

function get_goal_text(pl)
{
    return @"Gaada Goal , Maklum Lahh Masih Pengembangan Namanya"
}

        // MISSION CODEC Dont EDIT Anything
        // IF You An Developer , Please ReEdit And Upload
        // OPENWORLD Indonesia Game Studios - InsideOut Project
function get_result_text(pl)
{
   return @"Tidak Ada Goal Project"
}