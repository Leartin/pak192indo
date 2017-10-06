	/*
	/ Basic Infos
	/ Only Edit If you know the changes
	/ Code Dwach - VReWork ReMashUp
   */
map.file = "Lutfiafifi.sve"										// Map FileName ( EDIT )
scenario.short_description = "Everyone Can Play Simutrans"		// Scenario Names ( EDIT )
scenario.author = "Rengga Prakoso - vzrenggamani"				// Your Name HERE ( EDIT )
scenario.version = "0.2"										// Scenario Version ( EDIT )
scenario.translation = "Satria Naa'il Kayana Ritonga"			// Your Scenario Translator ( EDIT )

	/*
	/ INFO Codes And Something Usefull
	/ Only Edit If you know the changes
	/ Code Dwach - VReWork ReMashUp
   */
function get_rule_text(pl)							// Rules Text \ Something
{
	return ttextfile("rule.txt")					
}

function get_goal_text(pl)							// Goal Text \ Something
{
	local cash = get_cash(pl)
	local mapss = get_map_file()
	local PTS = get_transported_pax(pl)
	local OC = get_code_creator()
	local SA = get_author_info()
	
	local DASH = "<br><strong>------------</strong><br>"
	
	local OBJ = "<strong>--------------------------------</strong>"
	+ "<br><em>OBJECTIVE</em>"
	+ "<br><strong>--------------------------------</strong>"
	+ "<br>Kalian Punya 2 Misi Dalam Sekanrio Ini..."
	
	local textA = "Mendapatkan uang Sampai 1.000.000,- " + "<br><br><strong>STATUS!!</strong><br>MONEY : " + cash + ".<br> <br>"
	if ( cash >= 1000000 )
		textA += "<it>SELAMAT!!!</it> Kamu Telah Menyelesaikan Objektif Pertama"
	else
		textA += "Awww.. Masih Belum Kakak.. <it>Selamat Berjuang</it>"

	
	local textB = "Mendapatkan Penumpang Sampai 1.000.000,- " + "<br><br><strong>STATUS!!</strong><br>PASSENGER : " + PTS + ".<br> <br>"
	if ( PTS > 1000000 )
		textB += "<it>SELAMAT!!!</it> Kamu Telah Menyelesaikan Objektif Kedua"
	else
		textB += "Awww.. Masih Belum Kakak.. <it>Selamat Berjuang</it>"
	
	return OBJ + DASH + textA + DASH + textB
}

function get_info_text(pl)							// INFOS Text \ Something
{
	local cash = get_cash(pl)
	local mapss = get_map_file()
	local OC = get_code_creator()
	local SA = get_author_info()
	
	local PRE ="WELCOME To Simutrans Indonesia"
	+ "<br>--------------------------------"
	+ "<br>Kamu sedang memakai kreasi anak <strong>Simutrans Indonesia - SMI</strong>"
	+ "<br>Be Happy and Be Wise"
	
	local INFO ="<br><br>--------------------------------"
	+ "<br><em>SCENARIO INFOS</em>"
	+ "<br>--------------------------------<br>"
	+ "<br>Scenario Name : " + scenario.short_description
	+ "<br>scenario version : " + scenario.version
	+ "<br>Map File : " + mapss
	+ "<br><br>SCENARIO DEVELOPER :"
	+ "<br>Main Developer : " + OC
	+ "<br>ReWorked By : " + SA
	+ "<br>Translation By : " + scenario.translation
	+ "<br>Map By : " + "Rengga Prakoso"		// Map By :  ( EDIT )
	
	return PRE + INFO + "<br><br>" + ttextfile("info.txt")
}

function get_result_text(pl)						// Results Text \ Something
{
	local cash = get_cash(pl)
	local mapss = get_map_file()
	local PTS = get_transported_pax(pl)
	local OC = get_code_creator()
	local SA = get_author_info()

	
	local INFO = "<em>Map Name :</em> " +  mapss
	+ "<br><em>Version:</em> " +  scenario.version
	+ "<br><em>Translation:</em> " +  scenario.translation
	+ "<br><br><strong>--------------------------------</strong>"
	+ "<br><em>Game Statistics</em>"
	+ "<br><strong>--------------------------------</strong>"
	+ "<br><br><em>Player 1 Money : </em>" + cash
	+ "<br><br><em>Transported Passenger : </em>" + PTS
	+ "<br><br><em>COMING SOON :) :)</em>"
	+ "<br><br><strong>--------------------------------</strong>"
	+ "<br><em>SCENARIO STATUS!!!!</em>"
	+ "<br><strong>--------------------------------</strong>"
	
	local DASH = "<br><br><strong>------------</strong><br><br>"
	
	local textA = "<br><br>Your bank account is worth " + cash + ".<br> <br>"
	if ( cash >= 1000000 )
		textA += "<it>Congratulation!<br> <br> You won the scenario!</it>"
	else
		textA += "<it>You still have to work a little bit harder.</it>"
	
	local text1 = ttext("You already transported max. {PTS} passengers per month.<br> <br>")
	text1.PTS = PTS

	local textB = text1.tostring()
	if ( PTS > 1000000 )
		textB += ttext("<it>Congratulation! You won the scenario!</it>")
	else
		textB += ttext("<it>Local authorities are slowly losing patience with your poor transport network.</it>")
	
	return INFO + textA + DASH + textB
}

	/*
	/ GAMEPLAY And Some CODE Defintion
	/ Dont Edit if you dont know the function
	/ Code Dwach - VReWork ReMashUp
   */

function get_map_file()
{
	return map.file;
}

function get_author_info()
{
	return scenario.author;
}

function get_code_creator()
{
	return ttext ("Rengga Prakoso - vzrenggamani")
}

	/*
	/ MAIN CODES!!!
	/ Dont Edit if you dont know the function
	/ Code Dwach - VReWork ReMashUp
   */

book_slot <- null  // Something Useless

	// GET Transported Passanger
function get_transported_pax(pl)
{
	return player_x(pl).transported_pax.reduce( max )
}

	// GET Player 1 Cash
function get_cash(pl)
{
	return player_x(pl).cash[0]
}

	/*
	/ FINISH SCENARIO CODES
	/ Dont Edit if you dont know the function
	/ Code Dwach - VReWork ReMashUp
   */


function is_scenario_completed(pl)
{
	return (get_transported_pax(pl)*100) / 1000000 + get_cash(pl) / 10000
}