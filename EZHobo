script "ezhobo.ash";
/* GLOBAL VARS */
boolean hamster; 
boolean coat;
int turns;
string rlogs = visit_url("clan_raidlogs.php");


void preadv(){
if(item_amount($item[Autumn-aton]).to_boolean()){
    print("Sending your autumn-aton!", "green");
    cli_execute("autumnaton send Daily Dungeon"); //There'sprobably a better option but this is at least a +meat potion
}

if((have_effect($effect[Everything Looks Yellow]) == 0) && (available_amount($item[Jurassic Parka]).to_boolean())){
    print("Using your free YR!", "green");

    cli_execute("checkpoint");
    cli_execute("parka dilophosaur");
    equip($item[Jurassic Parka]);
    cli_execute("/aa none");

    string spit = "if hasskill bowl backwards; skill bowl backwards; endif; skill spit jurassic acid; abort;";
    adv1($location[The Dire Warren], -1, spit); //There is one hundred percent a better choice of yellow ray target that is avaiable to anyone, but this should work for testing
    if(handling_choice() == true){ run_choice(5); }
    cli_execute("outfit checkpoint");

} 

if((get_property("sweat") == 100) && (get_property("_sweatOutSomeBoozeUsed") == 3)){
    print("Sweating out some sweat!", "green");
    use_skill($skill[Make Sweat-ade]);
}

if(((get_property("_coldMedicineConsults")) <= 5) && visit_url("campground.php?action=workshed",false,true).contains_text('Extrovermectin&trade;')){
    visit_url("campground.php?action=workshed");
    run_choice(5);
} 


if(have_effect($effect[Beaten Up]).to_boolean()){
  string [int] cleaverQueue = get_property("juneCleaverQueue").split_string(",");

  if(cleaverQueue[cleaverQueue.count() - 1] == "1467" && have_skill($skill[Tongue of the Walrus])){
    use_skill(1, $skill[Tongue of the Walrus]);
  } else {
    abort("uh-oh. We lost the last combat.");
  }
}

}

/// /// /// /// ///
string combat_filter(int round, monster mon_encountered, string text) {
  
  if(mon_encountered.boss.to_boolean()){
    return "abort \"We encounted a boss!\"";
  }

/*
  if(mon_encountered == farm_monster) {
    print(`We hit a {mon_encountered}!`, "teal");
    // add more copies here kekw
    if(get_property("olfactedMonster").to_monster() != mon_encountered && have_skill($skill[Transcendent Olfaction]) && get_property("_olfactionsUsed") != 3){
      print("Olfacting!", "orange");
      set_property("olfactedMonster", mon_encountered);
      return "if hasskill Transcendent Olfaction; skill Transcendent Olfaction; endif; if hasskill Gallapagosian Mating Call; skill Gallapagosian Mating Call; endif; attack";
    }
    
  } else if (banish_monsters.to_string().contains_text(mon_encountered)){

    skill skill_banisher = get_unused_skill_banisher(my_location());
    
    if(skill_banisher != $skill[none]) {
      print(`Banishing with skill {skill_banisher.to_string()}!`, "orange");
      return "skill " + to_string(skill_banisher);
    }

    item item_banisher = get_unused_item_banisher(my_location());

    if(item_amount(item_banisher) > 0) {
      print(`Banishing with item {item_banisher.to_string()}!`, "orange");
      return "item " + to_string(item_banisher);
    }
  
  } else {
    abort("Monster not the farm monster nor monster wanted to banish");
  }
*/  
  

  print("We're all set! Attacking!", "orange");
  return "skill lunging-thrust";
}


/// /// /// /// ///







void buffme(string locat){
switch(locat){
  default:
    abort("Provide a valid location!");

    
}
}


boolean asc_skip; // TODO: Ascension skip, can_adventure()?

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


  string combat_filter = "if hasskill bowl a curveball; skill bowl a curveball; endif; if hasskill lunging-thrust smack; skill lunging-thrust smack; endif; attack; repeat !times 10";
  if(hamster){
    combat_filter = "lol runaway";
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
    adventure(1, $location[A maze of sewer tunnels], combat_filter);
    turns--;
    
    if(!have_equipped($item[gatorskin umbrella])){
      equip($item[gatorskin umbrella]);
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

  print(`Spending {arguments[1]} turns overkiling hobos with {arguments[0]}!`, "teal"); 
  element elemt = arguments[0].to_element();
  int parts_to_obtain = arguments[1].to_int();

  string hobo_combat = "skill stuffed mortar shell; use porquoise-handled sixgun; abort";

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

    if(expected_damage($monster[Normal Hobo]) > my_hp()){
      restore_hp(my_maxhp());
    }

    adventure($location[Hobopolis Town Square], 1, hobo_combat);

    parts_to_obtain--;
    turns--;


    if(turns <= 0){
      abort("Finished using all your set turns!");
    }

    print(`Turns remaining for element {elemt}: {parts_to_obtain}`, "teal");
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

  while(!contains_text(town_map, `clan_hobopolis.php?place={mapimage}`) && turns > 6){

    foreach elem in $elements[Hot, Cold, Stench, Spooky, Sleaze, None]{

      if (hobo_parts(elem) < 7){
        town_square_combat(`{elem} {7 - hobo_parts(elem)} {mapimage}`);
      }

      if (hobo_parts(elem) < 7){ 
        abort(`We didn't overkill! (Obtained {hobo_parts(elem)}/7 {elem} parts!)`);
      }
    }

    print("Launching 7 schobos!", "orange");
    visit_url("clan_hobopolis.php?place=3&action=talkrichard&whichtalk=3&preaction=simulacrum&qty=7");
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

  maximize("-combat 25 min 30 max, 0.8 bonus lucky gold ring, 0.4 bonus mafia thumb ring, 0.3 bonus cheeng's spectacles, 0.2 bonus can of mixed everything, 0.1 bonus designer sweatpants", false);

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
    turns--;
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

  maximize("-combat 25 min 30 max, 0.8 bonus lucky gold ring, 0.4 bonus mafia thumb ring, 0.3 bonus cheeng's spectacles, 0.2 bonus can of mixed everything, 0.1 bonus designer sweatpants", false);

  foreach x, outfit in get_custom_outfits(){
    if(contains_text(outfit.to_lower_case(), "esplanade")){
      outfit(outfit);
    }
  }

  while (get_property("lastEncounter") != "Bumpity Bump Bump"){

    if(hobo_lookup("diverted_water_to_PLD") >= 13 || get_property("ezhobo_EEBB_only") == "true"){
      set_property( "choiceAdventure215" , "3"); // Piping Cold: Go all CLUE
    }

    if(hobo_lookup("small_yodel") >= 11 && hobo_lookup("broke_pipe") % 30 == 0){ // Maybe check CLUE has broken 30 times also?
      set_property( "choiceAdventure217" , "3");	// There Goes Fritz: Yodel your heart out
    }

    preadv();

    if((expected_damage($monster[Cold Hobo]) + 250) > my_hp()){
      restore_hp(my_maxhp()); 
    }

    adventure(1, $location[Exposure Esplanade]);
    turns--;

  } 

  return visit_url("clan_hobopolis.php?place=5").contains_text("exposureesplanade10") || visit_url("clan_hobopolis.php?place=5").contains_text("exposureesplanade11");
} 
/*
boolean purple_light_district(string runtype){
    
  if(visit_url("clan_hobopolis.php?place=8").contains_text("purplelightdistrict10") || visit_url("clan_hobopolis.php?place=8").contains_text("purplelightdistrict11")){
    return true;
  }


  set_property( "choiceAdventure219" , "2");	//The Furtive of my City: Intimidate Him (Move trash to the heap)
  set_property( "choiceAdventure223" , "3");	//Getting Clubbed: Flimflam x8
  set_property( "choiceAdventure224" , "2");	//Kills 10% remaining sleaze hobos
  set_property( "choiceAdventure205" , "2");	//Van, Damn: Leave combat with Chester

  
  maximize("combat 25 min 30 max, 0.8 bonus lucky gold ring, 0.4 bonus mafia thumb ring, 0.3 bonus cheeng's spectacles, 0.2 bonus can of mixed everything, 0.1 bonus designer sweatpants", false);


  while (last_choice() != 205){
    

    if(hobo_lookup("flimflam") >= 8){
      set_property("choiceAdventure223" , "1"); //Getting Clubbed: Try to get inside 
    }

    preadv();
    adventure(1, $location[The Purple Light District]);
      

  }
  return visit_url("clan_hobopolis.php?place=8").contains_text("purplelightdistrict10") || visit_url("clan_hobopolis.php?place=8").contains_text("purplelightdistrict11");
}


*/



print("Usage: ezhobo {run type} {turns}");
void main(string args){

  string[int] options;
  options = split_string(args, " ");
  print(`Running {options[1]} turns and attempting a {options[0]} run, in clan "{get_clan_name()}"`, "teal"); 

  turns = to_int(options[1]);
  int current_turns = my_adventures();
  string run_type = to_lower_case(options[0]);

  switch(run_type){
    default:
    abort("Invalid location selection. Valid selections include: none, coat, hamster");
    
    case "none":
    break;

    case "coat":
    coat = true;
    break;

    case "hamster":
    hamster = true;
    coat = true; 
    break;
  }
  wait(1);
 /// /// /// /// /// TEST /// /// /// /// ////




 /// /// /// /// /// TEST /// /// /// /// ////
  if(have_familiar($familiar[Red-nosed snapper]) && my_familiar() != $familiar[Red-nosed Snapper]){
    use_familiar($familiar[Red-nosed snapper]);
    visit_url('familiar.php?action=guideme&pwd'); 
    visit_url('choice.php?pwd&whichchoice=1396&option=1&cat=hobo');
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
    print("Reached Frosty!", "orange");
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

}
