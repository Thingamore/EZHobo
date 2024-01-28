script "ezhobo_combat.ash";

string submit_combat(string filter) {
	string combat_submission_url = visit_url(`fight.php?action=macro&macrotext={filter}`, true, false);
	return combat_submission_url;
}
/*
// We could use append() in order to create a macro and submit it via the above 
*/

string hobo_combat(int round, monster mon_encountered, string pagetext) {

  if(mon_encountered.boss.to_boolean()){
    return "abort \"We encounted a boss!\"";
  }


  string my_location = my_location();

 // Global combat
  if(expected_damage(mon_encountered) > my_hp()){
    if(have_skill($skill[Ambidextrous Funkslinging]))
      return "use new age healing crystal, new age healing crystal";

    return "use new age healing crystal";
  }



 // Check for non-hobo zones. (e.g YRs from parka)
 if(substring(my_location().to_string(),0,11) == "Shadow Rift" || my_location() == $location[Thugnderdome])
   if(equipped_item($slot[Shirt]) != $item[Jurassic Parka]){
     abort("Went to YR without a parka on!");
   }

   return "skill Spit jurassic acid";
 }



 // Specific hobo combat
  switch(mon_encountered){
    case($monster[Normal Hobo]):
    

    if(round > 2){
      abort("The fight took more then two rounds! Aborting, as the stuffed shell didn't kill!");
    }

    if(round == 1){
      print("Launching a mortar!", "green");
      return "skill stuffed mortar shell";
    }

    if(my_familiar() == $familiar[Grey Goose] && familiar_weight(my_familiar()) > 20 && familiar_weight(my_familiar()) > 5){
      print("Emitting drones to stasis!", "green");
      return "skill emit matter duplicating drones";
    }

    if(have_skill($skill[Extract])){
      print("Extracting to stasis!", "green");
      return "skill Extract";
    }

    if(have_skill($skill[Sing Along]) && get_property("boomBoxSong") == "Total Eclipse of Your Meat"){
      print("Singing along to stasis!", "green");
      return "skill sing along";
    }

    if(item_amount($item[Porquoise-handled sixgun]).to_boolean()){
      print("Using a porquoise-handled sixgun to stasis!", "green");
      return "use Porquoise-handled sixgun";
    }

    print("Using a seal tooth to stasis!", "green");
    return "use seal tooth";

    case($monster[Hot Hobo]):
    return "skill Lunging Thrust-Smack";

    case($monster[Cold Hobo]):
    return "skill Lunging Thrust-Smack";

    case($monster[Stench Hobo]):

    if(have_skill($skill[Extract Jelly])){
      return "skill Extract Jelly";
    }
    break;

    case($monster[Sleaze Hobo]):
    break;

    case($monster[Spooky Hobo]):
    break;


    default:
      print(`We've hit a {mon_encountered} as a result of a wanderer! Defaulting to killing them!`, "orange");
      return "skill Lunging Thrust-Smack; repeat 10 !times";
  }

  print("Combat handling failed!", "orange");
  return `abort "Combat handling failed..."`;
 
}

void main(int initround, monster foe, string page) {
  submit_combat(hobo_combat(initround, foe, page)); // >.<
}
