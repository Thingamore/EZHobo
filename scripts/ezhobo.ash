script "ezhobo.ash";
import <ezhobo_combat.ash>

/* GLOBAL VARS */
boolean hamster; 
boolean coat;
int turns;
string rlogs = visit_url("clan_raidlogs.php");
int pipe_requirement = 40;

void newline() { 
	print("");
}

void help(){
print_html("<font size=4><b><center> Information: </center><font></b></font>");
newline();
print_html("<center> EZHobo is a script designed to optimally complete hobopolis for you. </center>");
print_html("<center> To use EZHobo, enter `ezhobo {run_type} {turns} in the GCLI, where run_type is stick/coat/hamster.` </center>");
newline();
print_html("<font size=3><b><center> Conditional Options: </center><font></b></font>");
newline();

print_html("<p><center>BOOLEAN <font color=66b2b2>ezhobo_doNotCloset</font> - Refrains from closeting nickles if using an LGR after combat.</center></p>");
newline();
print_html("<p><center>STRING <font color=66b2b2>ezhobo_zones </font> - List of full zone names you wish to complete, seperated via commas.</center></p>");
newline();
print_html("<p><center>INT <font color=66b2b2>ezhobo_square </font> - Only farms the square, stopping at the desired square image.</center></p>");
newline();
print_html("<p><center>BOOLEAN <font color=66b2b2>ezhobo_solo</font> - Are you running this script by yourself? Defaults to false. </center></p>");
print_html("<center> To adjust or set these options, type `set {option} = {input}` in the GCLI. </center>");
abort("");
}

void preadv(){

if (my_adventures() == 0 || turns <= 0){
  abort("No more alloted turns to spend!");
}

/* the following blocks are unrelated to hobopolis and are causing issues for some players (specifically the shadow rift visits) so i am commenting them out -Kuile

if(item_amount($item[Autumn-aton]).to_boolean()){
  print("Sending your autumn-aton!", "green");

  string autumnaton_location;
  foreach it in $locations[The Daily Dungeon, Thugnderdome, Shadow Rift]{
    if(can_adventure(it)){
      autumnaton_location = it.to_string();
    }
  }
  cli_execute(`autumnaton send {autumnaton_location}`);
}

if((have_effect($effect[Everything Looks Yellow]) == 0) && (available_amount($item[Jurassic Parka]).to_boolean() && (can_adventure($location[Shadow Rift]) || can_adventure($location[Thugnderdome])))){
  print("Using your free YR!", "green");  

  item prev_shirt = equipped_item($slot[Shirt]);

  equip($item[Jurassic Parka]);
  cli_execute("parka dilophosaur");

  if(can_adventure($location[Shadow Rift])){
    set_location($location[Shadow Rift]);
    adv1($location[Shadow Rift], -1);
  } else {
    set_location($location[Thugnderdome]);
    adv1($location[Thugnderdome], -1);
  }

  equip($slot[Shirt], prev_shirt);
    
} 

if((get_property("sweat") == 100) && (get_property("_sweatOutSomeBoozeUsed") == 3)){
  print("Sweating out some sweat!", "green");
  use_skill($skill[Make Sweat-ade]);
}

if(((get_property("_coldMedicineConsults")) <= 5) && visit_url("campground.php?action=workshed", false, true).contains_text('Extrovermectin&trade;')){
  visit_url("campground.php?action=workshed");
  run_choice(5);
} 

*/

if(item_amount($item[Hobo Nickel]) > 0 && !get_property("ezhobo_doNotCloset").to_boolean()){
  put_closet(item_amount($item[Hobo nickel]), $item[Hobo Nickel]);
}

if(have_effect($effect[Beaten Up]).to_boolean()){
  string [int] cleaverQueue = get_property("juneCleaverQueue").split_string(",");

  if(cleaverQueue[cleaverQueue.count() - 1] == "1467" && have_skill($skill[Tongue of the Walrus])){
    use_skill(1, $skill[Tongue of the Walrus]);
  } else {
    abort("uh-oh. We lost the last combat.");
  }
}

turns--;

}

/// /// /// /// ///

void buffme(string locat){
switch(locat){
  default:
    abort("Provide a valid location!");

    
}
}


boolean sewer_finished(string playerID) {
  if(playerID == my_id()){
    return !visit_url("clan_hobopolis.php").contains_text("adventure.php?snarfblat=166");
  }
  return contains_text(rlogs, `(#{playerId}) made it through the sewer`);
}


boolean sewers(string runtype){
  if(sewer_finished(my_id())){
    print("Sewer already finished!", 'teal');
    return true;
  }

  int sewer_time_start = now_to_int();

  if(!visit_url("clan_raidlogs.php").contains_text("ASSBot")){
    if(user_confirm("ASSBot does not seem to be in the clan raidlogs. Do you wish to stop for cagebait?")){
      abort("Aborted by user.");
    }
  }

  /* INFO: For matching water level */
  matcher water_level_matcher = create_matcher("lowered the water level\\s+(\\d+)\\s+times", rlogs);
  int wlev_turns;
  while (water_level_matcher.find()){
    wlev_turns = (water_level_matcher.group(1)).to_int();
  }

  print(`Water level: {wlev_turns}0 cm / 200 cm`);
  if(wlev_turns < 20 || !hamster){
    set_property ("choiceAdventure197" , "3") ;
  } else {
    set_property( "choiceAdventure197" , "1");
  }

  /* INFO: For matching grates opened*/
  matcher sewer_grate_matcher = create_matcher("\\bopened\\s+(\\d+)\\s+sewer grates?", rlogs);
  int sewer_grate_turns;

  while(sewer_grate_matcher.find()){
    sewer_grate_turns = (sewer_grate_matcher.group(1)).to_int();
  }

  print("Grates opened: " + sewer_grate_turns);

  if(sewer_grate_turns < 20 || !hamster){
    set_property ("choiceAdventure198" , "3") ;
  } else {
    set_property( "choiceAdventure198" , "1");
  }


  int [item] sewer_consumables = {
    $item[gatorskin umbrella] : 1,
    $item[unfortunate dumplings] : 1,
    $item[sewer wad] : 1,
    $item[bottle of ooze-o] : 1,
    $item[oil of oiliness] : 3,
  }; 

  set_property("choiceAdventure199", "1");

  set_property("choiceAdventure211", ""); // We should never gnaw bars =(
  set_property("choiceAdventure212", ""); 


  maximize("-combat 25 min 30 max, 999 bonus gatorskin umbrella, 3000 bonus hobo code binder", false);


  string sewer_combat = "if hasskill bowl a curveball; skill bowl a curveball; endif; if hasskill lunging-thrust smack; skill lunging-thrust smack; endif; attack; repeat !times 10";
  if(hamster){
    sewer_combat = "skill CLEESH;attack;";
  } 


  while (!sewer_finished(my_id())) {
    if (my_adventures() == 0 || turns <= 0){
      abort("No more turns to spend!");
    }

    foreach itm, qty in sewer_consumables{
      if(item_amount(itm) < qty && coat){
        retrieve_item(qty, itm);
      }
    }

    preadv();
    adventure(1, $location[A Maze of Sewer Tunnels], sewer_combat);

    
    if(!have_equipped($item[Gatorskin umbrella])){
      equip($item[Gatorskin umbrella]);
    }

    if(expected_damage($monster[C. H. U. M.]) > my_hp()){
      restore_hp(my_maxhp());
    }
  }

  print(`Sewers took: {floor((now_to_int() - sewer_time_start) / 60000)} minute(s) and {(floor(now_to_int() - sewer_time_start) % 60000 / 1000)} second(s)`, "lime");
  
  return sewer_finished(my_id());
}


int hobo_parts(element ele){

  string richard = visit_url("clan_hobopolis.php?place=3&action=talkrichard&whichtalk=3");	
  int hobopart_amount;

  element [string] parts = {
  "pair(s)? of charred hobo boot(s)?": $element[Hot],
  "pair(s)? of frozen hobo eyes": $element[Cold],
  "pile(s)? of stinking hobo guts": $element[Stench],
  "creepy hobo skull(s)?": $element[Spooky],
  "hobo crotch(es)?": $element[Sleaze],
  "hobo skin(s)?":$element[None],
  };


  foreach matcher_string, elem in parts{
    hobopart_amount = 0;
    matcher hoboparts = create_matcher(`Richard has <b>(\\d+)</b> {matcher_string}`, richard);
    while (hoboparts.find()) {
      hobopart_amount = hoboparts.group(1).to_int();
    }

    if(ele == elem){
      return hobopart_amount;
    }
  }

  return 0;
}


boolean confirm;
void town_square_combat(string settings) {

  string[int] arguments;
  arguments = split_string(settings, " ");

  print(`Spending {arguments[1]} turn overkiling hobos with {arguments[0]}!`, "teal"); 
  element elemt = arguments[0].to_element();
  int parts_to_obtain = arguments[1].to_int();

  int current_parts = elemt.hobo_parts();

  switch {
    default:
      abort("Provide an actual element!");

    case(elemt == $element[None]):
      use_skill($skill[Spirit of Nothing]);
      set_auto_attack("Lunging Thrust-Smack");
      break;

    case(elemt == $element[Hot]):
      use_skill($skill[Spirit of Cayenne]);
      set_auto_attack(0);
      break;

    case(elemt == $element[Cold]):
      use_skill($skill[Spirit of Peppermint]);
      set_auto_attack(0);
      break;

    case(elemt == $element[Stench]):
      use_skill($skill[Spirit of Garlic]);
      set_auto_attack(0);
      break;

    case(elemt == $element[Spooky]):
      use_skill($skill[Spirit of Wormwood]);
      set_auto_attack(0);
      break;

    case(elemt == $element[Sleaze]):
      use_skill($skill[Spirit of Bacon Grease]);
      set_auto_attack(0);
      break;
  }


  while(parts_to_obtain > 0 && !contains_text(visit_url("clan_hobopolis.php?place=2"), `clan_hobopolis.php?place={arguments[2]}`)){
    preadv();

    int expected_shell_damage = ((32) + (0.5 * my_buffedstat($stat[mysticality]))) * numeric_modifier("Spell Damage");
    if((expected_shell_damage < (500 + numeric_modifier("-Monster Level"))) && !confirm && elemt != $element[None]){
      if (!user_confirm("You may not be overkilling the hobos, are you sure you want to adventure?")){
        abort();
      }
      confirm = true;
    }

    if(expected_damage($monster[Normal Hobo]) * 2 > my_hp()){
      restore_hp(my_maxhp());
    }

    if(my_mp() < 40){
      restore_mp(400);
    }

    adventure($location[Hobopolis Town Square], 1);

    parts_to_obtain--;
   


    if(turns <= 0){
      abort("Finished using all your set turns!");
    }

    // print(`Turns remaining for element {elemt}: {parts_to_obtain}`, "teal");
  }

}

boolean town_square(int turnss, int mapimage){
  set_property("choiceAdventure272" , "2");

  string town_map = visit_url("clan_hobopolis.php?place=2");

  if (contains_text(town_map , `clan_hobopolis.php?place={mapimage}`)){
    return true;
  }

  boolean wearing_outfit;

  foreach x, outfit in get_custom_outfits(){
    if(contains_text(outfit.to_lower_case(), "hobo")){
      outfit(outfit);
      wearing_outfit = true;
    }
  }

  
  if(!wearing_outfit){
    if(!user_confirm("Please select an outfit to wear! Or save an outfit with the 'hobo' in it's name, and it'll default swapping to that! (YES to continue with current outfit)"))
      abort("User abort.");
  }

  while(!contains_text(town_map, `clan_hobopolis.php?place={mapimage}`)){

    foreach elem in $elements[Hot, Cold, Stench, Spooky, Sleaze, None]{

      if (hobo_parts(elem) < 1){
        town_square_combat(`{elem} 1 {mapimage}`);
      }
    }

    print("Launching a schobo!", "orange");
    visit_url("clan_hobopolis.php?place=3&action=talkrichard&whichtalk=3&preaction=simulacrum&qty=1");
  }

  return contains_text(town_map , `clan_hobopolis.php?place={mapimage}`); 
}


int hobo_lookup(string lookup){
string rlogs = visit_url("clan_raidlogs.php");

// Regex =(
switch(lookup.to_lower_case()){
  case "tire":
    int total_tires;
    matcher tire = create_matcher("(?<=threw\\s)\\d+(?=\\stires on the fire)", rlogs);
    while(tire.find()){
      total_tires += tire.group().to_int();
    }

  return total_tires;

  case "tirevalanche":
    int total_tirevalanches;
    matcher tirevalanches = create_matcher("tirevalanch.*?(\\d+) turn(s)?", rlogs);
    while(tirevalanches.find()){
      total_tirevalanches += tirevalanches.group(1).to_int();
    }

  return total_tirevalanches;

  case "diverted_water_to_pld":
    int water_diverted;
    matcher divert_water = create_matcher("diverted some cold water out of Exposure Esplanade.*?(\\d+) turn(s)?", rlogs); 
    while(divert_water.find()){
      water_diverted += divert_water.group(1).to_int();
    }

  return water_diverted;

  case "small_yodel":
    int small_yodels;
    matcher small_yodel_amount = create_matcher("yodeled a little bit.*?(\\d+) turn(s)?", rlogs); 
    while(small_yodel_amount.find()){
      small_yodels += small_yodel_amount.group(1).to_int();
    }

  return small_yodels;

  case "self_large_yodel":
  return rlogs.contains_text(`{my_id()}) yodeled like crazy`).to_int(); // TODO: Future support for ascending and yodeling large again

  case "broke_pipe":
    int broke_pipes;
    matcher amount_broken = create_matcher("broke (\\d+) water pipe(s)?", rlogs); 
    while(amount_broken.find()){
      broke_pipes += amount_broken.group(1).to_int();
    }

  return broke_pipes;

  case "flimflam":
    int flimflams;
    matcher matcher_flimflam = create_matcher("flimflamm[^\\d]*(\\d+)", rlogs); 
    while(matcher_flimflam.find()){
      flimflams += matcher_flimflam.group(1).to_int();
    }

  return flimflams;

  

  default:
    abort("Invalid lookup!");
}

return 0;
}

boolean burn_barrel(string runtype){

  if(visit_url("clan_hobopolis.php?place=4").contains_text("burnbarrelblvd10") || visit_url("clan_hobopolis.php?place=4").contains_text("burnbarrelblvd11")){
    return true;
  }

  set_property("choiceAdventure207", "2");	//Hot Dog!: Walk Away
  set_property("choiceAdventure213", "2");	//Piping Hot: Leave the valve alone
  set_property( "choiceAdventure201" , "2");	//Home in the Range: Leave combat with Ol' Scratch 

  maximize("-combat 25 min 30 max, 0.6 bonus Li'l Businessman Kit, 0.8 bonus lucky gold ring, 0.4 bonus mafia thumb ring, 0.3 bonus cheeng's spectacles, 0.2 bonus can of mixed everything, 0.1 bonus designer sweatpants", false);

  foreach x, outfit in get_custom_outfits(){
    if(contains_text(outfit.to_lower_case(), "burnbarrel")){
      outfit(outfit);
    }
  }



  while (get_property("lastEncounter") != "Home, Home in the Range"){

    if (my_adventures() == 0 || turns <= 0){
      abort("No more alloted turns to spend!");
    }

    set_property("choiceAdventure206", "2");	// Gently 

    int tire_amount = hobo_lookup("tire");
    int tirelaunches = hobo_lookup("tirevalanche");

    print(`INFO: Tirelaunches: {tirelaunches} | Tires stacked: {tire_amount} | This number should never be more then 34 or less then 0: {tire_amount - (tirelaunches * 34)}`, "orange");

    if(tire_amount % 34 == 0 && tire_amount > 0 && (tirelaunches + 1) * 34 == tire_amount){
      // Eg. We have 34 tires stacked now and 34 before (1 launch before), so we need to launch 'em twice this instance. As 68 (total tires stacked) / 34 is equal to two (required launches) and 2 > 1 (launches before), we'll launch them!
      // Afterwards, tire_amount % 34 is still 0, but now there's 2 launches (before) done already, and  2 !< 2, so we skip.

      set_property("choiceAdventure206", "1");	// Violently
      print("Preparing to set up a tirelaunch!", "orange");

    } 



    
    preadv();
    
    adventure(1, $location[Burnbarrel Blvd.]);
    
  }

  return visit_url("clan_hobopolis.php?place=4").contains_text("burnbarrelblvd10") || visit_url("clan_hobopolis.php?place=4").contains_text("burnbarrelblvd11");

}

boolean exposure_esplanade(string runtype){

  if(visit_url("clan_hobopolis.php?place=5").contains_text("exposureesplanade10") || visit_url("clan_hobopolis.php?place=5").contains_text("exposureesplanade11")){
    return true;
  }

  set_property( "choiceAdventure273" , "1");	// The Frigid Air: Acquire Frozen Banquet
  set_property( "choiceAdventure217" , "1");	// There Goes Fritz: Yodel a little
  set_property( "choiceAdventure202" , "2");	// Bumpity Bump Bump: Leave combat with Frosty
  set_property( "choiceAdventure215" , "2");	// Piping Cold: Divert Water to PLD

  maximize("-combat 25 min 30 max, 0.6 bonus Li'l Businessman Kit, 0.8 bonus lucky gold ring, 0.4 bonus mafia thumb ring, 0.3 bonus cheeng's spectacles, 0.2 bonus can of mixed everything, 0.1 bonus designer sweatpants", false);

  foreach x, outfit in get_custom_outfits(){
    if(contains_text(outfit.to_lower_case(), "esplanade")){
      outfit(outfit);
    }
  }

  while (get_property("lastEncounter") != "Bumpity Bump Bump" || (!get_property("ezhobo_solo").to_boolean() && hobo_lookup("self_large_yodel").to_boolean())){
    

    if(hobo_lookup("diverted_water_to_PLD") >= 13 || get_property("ezhobo_EEBB_only") == "true"){
      set_property( "choiceAdventure215" , "3"); // Piping Cold: Go all CLUE
    }

    // 40 for multiple people, 50 for solo
    if(hobo_lookup("small_yodel") >= 11 && hobo_lookup("broke_pipe") >= pipe_requirement){ // Maybe check CLUE has broken 30 times also?
      set_property( "choiceAdventure217" , "3");	// There Goes Fritz: Yodel your heart out
    }

    preadv();

    if((expected_damage($monster[Cold Hobo]) + 250) > my_hp()){
      restore_hp(my_maxhp()); 
    }

    adventure(1, $location[Exposure Esplanade]);
    

  } 

  return visit_url("clan_hobopolis.php?place=5").contains_text("exposureesplanade10") || visit_url("clan_hobopolis.php?place=5").contains_text("exposureesplanade11") || hobo_lookup("self_large_yodel").to_boolean();
} 





boolean purple_light_district(string runtype){
    
  if(visit_url("clan_hobopolis.php?place=8").contains_text("purplelightdistrict10") || visit_url("clan_hobopolis.php?place=8").contains_text("purplelightdistrict11")){
    return true;
  }

  set_property( "choiceAdventure219" , "2");	//The Furtive of my City: Intimidate Him (Move trash to the heap)
  set_property( "choiceAdventure223" , "3");	//Getting Clubbed: Flimflam x8
  set_property( "choiceAdventure224" , "2");	//Kills 10% remaining sleaze hobos
  set_property( "choiceAdventure205" , "2");	//Van, Damn: Leave combat with Chester

  
  maximize("combat 25 min 30 max, 0.6 bonus Li'l Businessman Kit, 0.8 bonus lucky gold ring, 0.4 bonus mafia thumb ring, 0.3 bonus cheeng's spectacles, 0.2 bonus can of mixed everything, 0.1 bonus designer sweatpants", false);

  foreach x, outfit in get_custom_outfits(){
    if(contains_text(outfit.to_lower_case(), "district")){
      outfit(outfit);
    }
  }

  while (get_property("lastEncounter") != "Van, Damn"){
    if(hobo_lookup("flimflam") >= 8){
      set_property("choiceAdventure223" , "1"); //Getting Clubbed: Try to get inside 
    }

    preadv();
    adventure(1, $location[The Purple Light District]);
    
  }

  return visit_url("clan_hobopolis.php?place=8").contains_text("purplelightdistrict10") || visit_url("clan_hobopolis.php?place=8").contains_text("purplelightdistrict11");
}




print("Usage: ezhobo {run type} {turns}", "orange");
void main(string args){

  string[int] options;
  options = split_string(args, " ");

  if(options[0] == "help"){
    help();
  }

  print(`Running {options[1]} turns and attempting a {options[0]} run, in clan "{get_clan_name()}"`, "teal"); 

  turns = to_int(options[1]);
  int current_turns = my_adventures();
  string run_type = to_lower_case(options[0]);

  switch(run_type){
    default:
    abort("Invalid location selection. Valid selections include: stick, coat, hamster");

    case "stick":
    break;

    case "coat":
    coat = true;
    break;

    case "hamster":
    hamster = true;
    coat = true; 
    break;
  }

  if(get_property("ezhobo_zones") != ""){
    string [int] zones_to_do = split_string(get_property("ezhobo_zones"), ",");
  }

  wait(1);

 /// /// /// /// /// TEST /// /// /// /// ////




 /// /// /// /// /// TEST /// /// /// /// ////


  // Sets a CCS to consult ezhobo_combat.ash when fighting monsters
  string prev_ccs = get_property('customCombatScript');
  buffer ccs;

  ccs.append("[default]");
  ccs.append("\n");
  ccs.append("consult ezhobo_combat.ash");

  write_ccs(ccs, "ezhobo_ccs");
  set_property('customCombatScript',"ezhobo_ccs");

  



  if(have_familiar($familiar[Red-nosed snapper]) && my_familiar() != $familiar[Red-nosed Snapper]){
    use_familiar($familiar[Red-nosed snapper]);
    visit_url('familiar.php?action=guideme&pwd'); 
    visit_url('choice.php?pwd&whichchoice=1396&option=1&cat=hobo');
  }


  if(get_property("ezhobo_solo").to_boolean()){
    pipe_requirement = 50;
  }

  set_auto_attack(0);
  set_property("currentMood", "apathetic");

  if(sewers(run_type)){
    print("The sewers have been navigated.", "orange");
  } else {
    abort("Failed trekking through the sewers.");
  }

  if(town_square(turns, 5)){
    print("There is 500 or greater kills in the square.", "orange");
  } else {
    abort("Failed killing 500 or more hobos in the town square.");
  }

  if(exposure_esplanade(run_type)){
    if(hobo_lookup("self_large_yodel").to_boolean()){
      print("You've already yodeled your heart out!", "orange");
    } else {
      print("Reached Frosty!", "orange");
    }

  } else {
    abort("Failed to reach Frosty in EE.");
  }

  if(burn_barrel(run_type)){
    print("Reached Ol' Scratch!", "orange");
  } else {
    abort("Failed to reach Ol' Scratch in burnbarrel.");
  }

  if(town_square(turns, 11)){
    print("There is 1250 or greater kills in the square.", "orange");
  } else {
    abort("Failed killing 1250 or more hobos in the town square.");
  }
/*
  if(purple_light_district(run_type)){
    print("Reached Chester!", "orange");
  } else {
    abort("Failed to reach Chester in PLD.");
  }
*/




  if(town_square(turns, 26)){
    print("There is 3000 or greater kills in the square.", "orange");
  } else {
    abort("Failed killing 3000 or more hobos in the town square.");
  }

  set_property('customCombatScript', prev_ccs);

}
