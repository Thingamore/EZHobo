print ("Beginning your journey into Hobopolis starting with Stage 1: The Maze of Sewer Tunnels.", "orange");
cli_execute( "set hpAutoRecovery=0.25;" );
cli_execute( "set mpAutoRecovery=0.25;" );

//Step 1: A Maze of Sewer Tunnels; spends 100 turns beating up sewer momsnters to get Sewer test items.
if ( contains_text( visit_url("clan_hobopolis.php?place=2") , "clan_hobopolis.php?place=3") ) 
    {
    print ("The Maze of Sewer Tunnels is already clear.", "orange") ; //If Richard's Redout is available, Sewer Maze has been complete.
    }
    else
    {
    set_property( "choiceAdventure198" , "2"); //Disgustin' Junction, zombie goldfish
    set_property( "choiceAdventure197" , "2"); //Somewhat Higher and Mostly Dry, sewer gator
    set_property( "choiceAdventure199" , "2"); //The Former or the Ladder, CHUM
    set_property( "choiceAdventure211" , "1"); //Caging, gnaw bars (ASSBot should be in place though)
    set_property( "choiceAdventure212" , "1"); //Caging, gnaw bars (ASSBot should be in place though)

    // To Snapper Up for humanoids in the sewers for some extra love. 
    if( have_familiar($familiar[Red-nosed snapper]) && my_familiar() != $familiar[Red-nosed Snapper] ){
        use_familiar($familiar[Red-nosed snapper]);}
    if( my_familiar() == $familiar[Red-nosed Snapper] ){  
        visit_url('familiar.php?action=guideme&pwd'); 
        visit_url('choice.php?pwd&whichchoice=1396&option=1&cat=humanoid');} 

    //Pre adventuring checks...
    cli_execute( "mood apathetic" ); //Safety check      
    maximize("item drop, -equip broken champagne bottle, equip Li'l Businessman Kit, equip lucky gold ring, equip mafia thumb ring, equip carnivorous potted plant, equip mr. cheeng's spectacles", false);
    cli_execute( "set customCombatScript = Slogo;" ); //Hobo CCS
    set_auto_attack(0); //Safety check

    //Starting our adventuring loop
    while (get_property("lastEncounter") != "At Last!")
        {	
        if (my_adventures() == 0)
            {
            print ("You have ran out of adventures in the Maze of Sewers Tunnels.", "orange");
            exit;
            }
        if (my_adventures() < 10)
            {
            print ("You do not have enough adventures to enter the Maze of Sewer Tunnels.", "orange");
            exit;
            }
        adventure(1, $location[a maze of sewer tunnels]);
        } //We either hit At Last or run out of adventures.    
    print("You have cleared the Maze of Sewer Tunnels.", "orange");
    set_auto_attack(0); //Safety check after doing anything
    cli_execute( "mood apathetic" ); //Safety check after doing anything     
    }

print ("Stage 1: A Maze Of Sewer Tunnels is complete. Moving on to Stage 2: Town Square Part 1", "orange");
//abort ( "Testing."); //For Testing

//Step 2: Town Square part 1; scobos until all of the side areas are open.
if ( contains_text( visit_url("clan_hobopolis.php?place=2") , "clan_hobopolis.php?place=8") )
    {
    print ("Side areas are already unlocked.", "orange") ;
    }
    else
    {
    //To Snapper Up for hobos and that sweet sweet cologne
    if( have_familiar($familiar[Red-nosed snapper]) && my_familiar() != $familiar[Red-nosed Snapper] ){
        use_familiar($familiar[Red-nosed snapper]);}
    if( my_familiar() == $familiar[Red-nosed Snapper] ){  
        visit_url('familiar.php?action=guideme&pwd'); 
        visit_url('choice.php?pwd&whichchoice=1396&option=1&cat=hobo');} 
    //Pre adventuring systems check...
    cli_execute( "set customCombatScript = Slogo;" );
    set_property( "choiceAdventure272" , "2"); //No marketplace
    //Starting our adventuring loop. This can undoubtedly be replaced with a better system, but this works for our purposes here.
    repeat
    {
    set_auto_attack(0);
    maximize("spell dmg, -equip witch's bra, equip Li'l Businessman Kit, equip lucky gold ring, equip mafia thumb ring, equip cheeng's spectacles, equip can of mixed everything", false);
    use_skill($skill[Spirit of Cayenne]); //Hot
    adventure($location[Hobopolis Town Square], 1);
    use_skill($skill[Spirit of Peppermint]); //Cold
    adventure($location[Hobopolis Town Square], 1);
    use_skill($skill[Spirit of Garlic]); //Stinky
    adventure($location[Hobopolis Town Square], 1);
    use_skill($skill[Spirit of Wormwood]); //Spook
    adventure($location[Hobopolis Town Square], 1);
    use_skill($skill[Spirit of Bacon Grease]); //Sleaze
    adventure($location[Hobopolis Town Square], 1);
    maximize("weapon dmg, equip Li'l Businessman Kit, equip lucky gold ring, equip mafia thumb ring, equip cheeng's spectacles, equip can of mixed everything", false);
    use_skill($skill[Spirit of Nothing]); //Nothing
    set_auto_attack("Lunging Thrust-Smack");
    adventure($location[Hobopolis Town Square], 1);
    visit_url("clan_hobopolis.php?place=3&action=talkrichard&whichtalk=3&preaction=simulacrum&qty=1"); //Richard for scobo
    
    if ( contains_text( visit_url("clan_hobopolis.php?place=2") , "townsquare11.gif") ) //After much testing, using the TownSquare image allows the loop to catch the opening of areas.
    {
        cli_execute( "mood apathetic" );
        set_auto_attack(0);                
        print ("Side areas are now unlocked.", "orange");
        break;
    }

    if (my_adventures() == 0)
    {
        cli_execute( "mood apathetic" );
        set_auto_attack(0);
        print ("You have ran out of adventures in the Town Square.", "orange");
        exit;
    }

    } until (my_adventures() == 0); //If PLD is not open, make scobos until either img11 appears or adv = 0. Easy enough.
    }
print ("Stage 2: Town Square Part 1 is complete. Moving on to Stage 3: Exposure Esplanade.", "orange");
//abort ( "Testing."); //For Testing

//Step 3. Exposure Esplanade; breaks 105 pipes, diverts water 13x, and then makes a big yodel. Ideally.
if ( contains_text( visit_url("clan_hobopolis.php?place=5") , "exposureesplanade11.gif") )
	{
	print ("Frosty is already prepared.", "orange") ;
    }
	else
	{
	if ( contains_text( visit_url("clan_hobopolis.php?place=5") , "exposureesplanade10.gif") )
	{
	print ("Frosty is already prepared.", "orange") ;
	}
    else
    {
    //To Snapper Up for hobos and that sweet sweet cologne
    if( have_familiar($familiar[Red-nosed snapper]) && my_familiar() != $familiar[Red-nosed Snapper] ){
        use_familiar($familiar[Red-nosed snapper]);}
    if( my_familiar() == $familiar[Red-nosed Snapper] ){  
        visit_url('familiar.php?action=guideme&pwd'); 
        visit_url('choice.php?pwd&whichchoice=1396&option=1&cat=hobo');} 
    //Pre adventuring systems check...
    maximize("-combat 25 min, equip Jurassic Parka, equip Li'l Businessman Kit, equip lucky gold ring, equip mafia thumb ring, equip cheeng's spectacles, equip carnivorous potted plant", false);
    cli_execute( "set customCombatScript = Slogo;" );
    cli_execute( "parka hot" ); //NC Boost
    cli_execute( "mood eenc" ); //Boosts NC and passive damage
    set_property( "choiceAdventure273" , "1");	//The Frigid Air: Acquire Frozen Banquet
    set_property( "choiceAdventure217" , "1");	//There Goes Fritz: Small yodels
    set_property( "choiceAdventure202" , "2");	//Bumpity Bump Bump: Leave combat with Frosty
    set_property( "choiceAdventure215" , "3");	//Piping Cold: Divert Water to PLD x13 (2), go all Clue (3)
    set_auto_attack(0);
    //Starting our adventuring loop.
    repeat		
    {
    if (contains_text( visit_url("clan_raidlogs.php") , my_id() + ") broke 105 water pipes (105 turns)"))
        {
        set_property( "choiceAdventure215" , "2"); //Piping cold, diverting water
        }
    if (contains_text( visit_url("clan_raidlogs.php") , my_id() + ") diverted some cold water out of Exposure Esplanade (13 turns)"))
        {
        set_property( "choiceAdventure215" , "3"); //Back to pipes so as to not waste turns
        set_property( "choiceAdventure217" , "3"); //Fritz, yodelling time
        }
    adventure(1, $location[Exposure Esplanade]) ;
    if (my_adventures() == 0)
        {
        cli_execute( "mood apathetic" );
        set_auto_attack(0);
        print ("You have ran out of adventures in Exposure Esplanade.", "orange");
        exit;
        }
    }until ((last_choice() == 202));

    if (last_choice() == 202)
    {
        cli_execute( "mood apathetic" );
        set_auto_attack(0);
        print("Frosty is now prepared.", "orange");
    }
    }
    }
print ("Stage 3: Exposure Esplanade is complete. Moving on to Stage 4: Burnbarrel Boulevard.", "orange");
//abort ( "Testing."); //For Testing

//Step 4. Burnbarrel Blvd; kills hot hobos while making three stacks of 34 tires and knocking them down.
if ( contains_text( visit_url("clan_hobopolis.php?place=4") , "burnbarrelblvd11.gif") )
	{
    print ("Ol' Scratch is already defeated.", "orange") ;
	}
	else
	{
	if ( contains_text( visit_url("clan_hobopolis.php?place=4") , "burnbarrelblvd10.gif") )
	{
    print ("Ol' Scratch is already prepared.", "orange") ;
	}
	else
	{
	//To Snapper Up for hobos and that sweet sweet cologne
    if( have_familiar($familiar[Red-nosed snapper]) && my_familiar() != $familiar[Red-nosed Snapper] ){
        use_familiar($familiar[Red-nosed snapper]);}
    if( my_familiar() == $familiar[Red-nosed Snapper] ){  
        visit_url('familiar.php?action=guideme&pwd'); 
        visit_url('choice.php?pwd&whichchoice=1396&option=1&cat=hobo');} 
	//Pre adventuring systems check...
	set_property( "choiceAdventure206" , "2");	//Getting Tired: (Toss a Tire Gently (2) x34, violently (1) x1)x3
	set_property( "choiceAdventure207" , "2");	//Hot Dog!: Walk Away
	set_property( "choiceAdventure213" , "2");	//Piping Hot: Leave the valve alone
	set_property( "choiceAdventure201" , "2");	//Home in the Range: Leave combat with Ol' Scratch (0 will show in browser)
	maximize("-combat, equip jurassic Parka, equip Li'l Businessman Kit, equip lucky gold ring, equip mafia thumb ring, equip cheeng's spectacles, equip carnivorous potted plant", false);
	cli_execute( "set customCombatScript = Slogo;" );
	cli_execute( "parka hot" );
	cli_execute( "mood nc" );
	//Starting our adventuring loop.
	repeat
	{
	set_property( "choiceAdventure206" , "2");	
	if (contains_text( visit_url("clan_raidlogs.php") , my_id() + ") threw 34 tires on the fire (34 turns)"))
		set_property( "choiceAdventure206" , "1");
	if (contains_text( visit_url("clan_raidlogs.php") , my_id() + ") started a tirevalanche (1 turn)"))
		set_property( "choiceAdventure206" , "2");	
	if (contains_text( visit_url("clan_raidlogs.php") , my_id() + ") threw 68 tires on the fire (68 turns)"))
		set_property( "choiceAdventure206" , "1");
	if (contains_text( visit_url("clan_raidlogs.php") , my_id() + ") started 2 tirevalanches (2 turns)"))
		set_property( "choiceAdventure206" , "2");					
	if (contains_text( visit_url("clan_raidlogs.php") , my_id() + ") threw 102 tires on the fire (102 turns)"))
		set_property( "choiceAdventure206" , "1");
	if (contains_text( visit_url("clan_raidlogs.php") , my_id() + ") started 3 tirevalanches (3 turns)"))
		set_property( "choiceAdventure206" , "2");			
	adventure(1, $location[Burnbarrel Blvd.]) ;	
	if (my_adventures() == 0)
	{
		cli_execute( "mood apathetic" );
		set_auto_attack(0);
		print ("You have ran out of adventures in Burnbarrel Boulevard.", "orange");
		exit;
	}
	} until ((last_choice() == 201));

	if (last_choice() == 201)
	{
		cli_execute( "mood apathetic" );
		set_auto_attack(0);
		print("Ol' Scratch is now prepared.", "orange");
	}
	}
	}
print ("Stage 4: Burnbarrel Boulevard is now complete. Moving on to Stage 5: The Purple Light District.", "orange");
//abort ( "Testing."); //For Testing

//Step 5. The Purple Light District; flimflam 8 times for A Chiller Night in AHBG and then clubs more sleaze hobos until clear.
if ( contains_text( visit_url("clan_hobopolis.php?place=8") , "purplelightdistrict11.gif") )
	{
    print ("Chester is already defeated.", "orange") ;
	}
	else
	{
	if ( contains_text( visit_url("clan_hobopolis.php?place=8") , "purplelightdistrict10.gif") )
	{
    print ("Chester is already prepared.", "orange") ;
	}
	else
    {
    //To Snapper Up for hobos and that sweet sweet cologne
    if( have_familiar($familiar[Red-nosed snapper]) && my_familiar() != $familiar[Red-nosed Snapper] ){
        use_familiar($familiar[Red-nosed snapper]);}
    if( my_familiar() == $familiar[Red-nosed Snapper] ){  
        visit_url('familiar.php?action=guideme&pwd'); 
        visit_url('choice.php?pwd&whichchoice=1396&option=1&cat=hobo');} 
    //Pre adventuring systems check...
	set_property( "choiceAdventure219" , "2");	//The Furtive of my City: Intimidate Him (Move trash to the heap)
	set_property( "choiceAdventure223" , "3");	//Getting Clubbed: Flimflam (3) x8, Try to get inside (1)
	set_property( "choiceAdventure224" , "2");	//Kills 10% remaining sleaze hobos
	set_property( "choiceAdventure205" , "2");	//Van, Damn: Leave combat with Chester
	maximize("+combat, equip jurassic Parka, equip Li'l Businessman Kit, equip lucky gold ring, equip mafia thumb ring, equip cheeng's spectacles, equip carnivorous potted plant", false);
	cli_execute( "set customCombatScript = Slogo;" );
	cli_execute( "parka sleaze" );
	cli_execute( "remedy smooth movements, the sonata of sneakiness, patent invisibility" );
	cli_execute( "mood pld" );
    //Starting our adventuring loop.
	repeat
	{

	if (contains_text( visit_url("clan_raidlogs.php") , my_id() + ") flimflammed some hobos (8 turns)"))
		{
		set_property( "choiceAdventure223" , "1");
		}
	adventure(1, $location[The Purple Light District]) ;

	if (my_adventures() == 0)
    {
		cli_execute( "mood apathetic" );
		set_auto_attack(0);
		print ("You have ran out of adventures in th Purple Light District.", "orange");
		exit;
    }

	} until ((last_choice() == 205));	
    
	if (last_choice() == 205)
    {
        cli_execute( "mood apathetic" );
        set_auto_attack(0);
        print("Chester is now prepared.", "orange");
    }
	}
    }
print ("Stage 5: The Purple Light District is complete. Moving on to Stage 6: The Ancient Hobo Burial Ground.", "orange");
//abort ( "Testing."); //For Testing

//Step 6. The Ancient Hobo Burial Ground
if ( contains_text( visit_url("clan_hobopolis.php?place=7") , "burialground11.gif") )
	{
    print ("Zombo is already defeated.", "orange") ;
	}
	else
	{
	if ( contains_text( visit_url("clan_hobopolis.php?place=7") , "burialground10.gif") )
	{
    print ("The dead shall not walk the earth under your watch little one...", "orange") ;
	}
	else
    {
    //To Snapper Up for hobos and that sweet sweet cologne
    if( have_familiar($familiar[Red-nosed snapper]) && my_familiar() != $familiar[Red-nosed Snapper] ){
        use_familiar($familiar[Red-nosed snapper]);}
    if( my_familiar() == $familiar[Red-nosed Snapper] ){  
        visit_url('familiar.php?action=guideme&pwd'); 
        visit_url('choice.php?pwd&whichchoice=1396&option=1&cat=hobo');} 	
    //Pre adventuring systems check...
	set_property( "choiceAdventure220" , "2");	//Returning to the tomb: Disturb not ye these bones (skip adventure)
	set_property( "choiceAdventure208" , "2");	//Ah, so that's where they've gone: Tiptoe through the tulips (skip adventure)
	set_property( "choiceAdventure221" , "1");	//A Chiller Night (1): Study the hobos' dance moves, then dance with them
	set_property( "choiceAdventure222" , "1");	//A Chiller Night: Dance with them x23
	set_property( "choiceAdventure204" , "2");	//Welcome to You: Leave combat with Zombo (0 will show in browser)
	maximize("-combat, equip jurassic Parka, equip Li'l Businessman Kit, equip lucky gold ring, equip mafia thumb ring, equip cheeng's spectacles, equip carnivorous potted plant", false);
	cli_execute( "set customCombatScript = Slogo;" );
	cli_execute( "parka hot" ); //NC boost
	cli_execute( "remedy carlweather's cantata, everything must go, high colognic, lion in ambush, musk of the moose" );
	cli_execute( "mood nc" );
    //Starting our adventuring loop.
	repeat
	{
	adventure(1, $location[The Ancient Hobo Burial Ground]) ;
	if (my_adventures() == 0)
    {
		cli_execute( "mood apathetic" );
		set_auto_attack(0);
		print ("You have ran out of adventures in the Burial Ground.", "orange");
		exit;
    }
	} until ((last_choice() == 204));
	
	if (last_choice() == 204)
    {
        cli_execute( "mood apathetic" );
        set_auto_attack(0);
        print("Zombo is now prepared.", "orange");
    }
	}
    }
print ("Stage 6: The Ancient Hobo Burial Ground is now complete. Moving on to Stage 7: The Heap.", "orange");	
//abort ( "Testing."); //For Testing

//Step 7. The Heap
if ( contains_text( visit_url("clan_hobopolis.php?place=6") , "theheap11.gif") )
	{
    print ("Oscus is already defeated.", "orange") ;
	}
	else
	{
	if ( contains_text( visit_url("clan_hobopolis.php?place=6") , "theheap10.gif") )
	{
    print ("Oscus is already prepared.", "orange") ;
	}
	else
    {
    //To Snapper Up for hobos and that sweet sweet cologne	
    if( have_familiar($familiar[Red-nosed snapper]) && my_familiar() != $familiar[Red-nosed Snapper] ){
        use_familiar($familiar[Red-nosed snapper]);}
    if( my_familiar() == $familiar[Red-nosed Snapper] ){  
        visit_url('familiar.php?action=guideme&pwd'); 
        visit_url('choice.php?pwd&whichchoice=1396&option=1&cat=hobo');} 
    //Pre adventuring systems check...
	set_property( "choiceAdventure218" , "1");	//I Refuse: Explore the Junkpile
	set_property( "choiceAdventure216" , "2");	//The Compostal Service: Begone (Needs to be used (1) periodically though)
	set_property( "choiceAdventure214" , "1");	//You vs. The Volcano: Kick Stuff into the Hole
	set_property( "choiceAdventure203" , "2");	//Deep Enough to Dive: Leave combat with Oscus (0 will show in browser)
	maximize("-combat, equip jurassic Parka, equip Li'l Businessman Kit, equip lucky gold ring, equip mafia thumb ring, equip cheeng's spectacles, equip carnivorous potted plant", false);
	cli_execute( "set customCombatScript = Slogo;" );
	cli_execute( "parka hot" ); //NC Boost
	cli_execute( "mood nc" );
	//Starting our adventuring loop.
	repeat
	{
	set_property( "choiceAdventure216" , "2");
	string page_text = visit_url("clan_raidlogs.php") ;
	if (contains_text( page_text , my_id() + ") started 4 trashcano eruptions (4 turns)"))
		set_property( "choiceAdventure216" , "1");
	if (contains_text( page_text , my_id() + ") started 12 trashcano eruptions (12 turns)"))
		set_property( "choiceAdventure216" , "1");
	if (contains_text( page_text , my_id() + ") started 20 trashcano eruptions (20 turns)"))
		set_property( "choiceAdventure216" , "1");
	if (contains_text( page_text , my_id() + ") started 28 trashcano eruptions (28 turns)"))
		set_property( "choiceAdventure216" , "1");
	if (contains_text( page_text , my_id() + ") started 36 trashcano eruptions (36 turns)"))
		set_property( "choiceAdventure216" , "1");
	if (contains_text( page_text , my_id() + ") started 44 trashcano eruptions (44 turns)"))
		set_property( "choiceAdventure216" , "1");
	if (contains_text( page_text , my_id() + ") started 52 trashcano eruptions (52 turns)"))
		set_property( "choiceAdventure216" , "1");
	if (contains_text( page_text , my_id() + ") started 60 trashcano eruptions (60 turns)"))
		set_property( "choiceAdventure216" , "1");
	if (contains_text( page_text , my_id() + ") started 68 trashcano eruptions (68 turns)"))
		set_property( "choiceAdventure216" , "1");
	if (contains_text( page_text , my_id() + ") started 76 trashcano eruptions (76 turns)"))
		set_property( "choiceAdventure216" , "1");
	if (contains_text( page_text , my_id() + ") started 84 trashcano eruptions (84 turns)"))
		set_property( "choiceAdventure216" , "1");
	if (contains_text( page_text , my_id() + ") started 92 trashcano eruptions (92 turns)"))
		set_property( "choiceAdventure216" , "1");
	if (contains_text( page_text , my_id() + ") started 100 trashcano eruptions (100 turns)"))
		set_property( "choiceAdventure216" , "1");
	if (last_choice() == 218)
		set_property( "choiceAdventure216" , "1");
	if (last_choice() == 216)
		set_property( "choiceAdventure216" , "2");
	adventure(1, $location[The Heap]);
	if (my_adventures() == 0)
    {
		cli_execute( "mood apathetic" );
		set_auto_attack(0);
		print ("You have ran out of adventures in The Heap.", "orange");
		exit;
    }
	}  until ((last_choice() == 203));

	if (last_choice() == 203)
    {
        cli_execute( "mood apathetic" );
        set_auto_attack(0);
        print("Oscus is now prepared.", "orange");
    }
	}
    }
print ("Stage 7: The Heap is now complete. Moving on to Stage 8: Town Square part 2.", "orange");	
//abort ( "Testing."); //For Testing

//Step 8: Town Square part 2
if ( contains_text( visit_url("clan_hobopolis.php?place=2") , "townsquare25o.gif") )
    {
    print ("Hodgman is already prepared.", "orange") ;
    }
    else
    {
    //To Snapper Up for hobos and that sweet sweet cologne
    if( have_familiar($familiar[Red-nosed snapper]) && my_familiar() != $familiar[Red-nosed Snapper] ){
        use_familiar($familiar[Red-nosed snapper]);}
    if( my_familiar() == $familiar[Red-nosed Snapper] ){  
        visit_url('familiar.php?action=guideme&pwd'); 
        visit_url('choice.php?pwd&whichchoice=1396&option=1&cat=hobo');} 
    //Pre adventuring systems check...
    cli_execute( "set customCombatScript = Slogo;" );
    set_property( "choiceAdventure272" , "2"); //No marketplace
    //Starting our adventuring loop.
    repeat
    {     
    maximize("spell dmg, -equip witch's bra, equip Li'l Businessman Kit, equip lucky gold ring, equip mafia thumb ring, equip cheeng's spectacles, equip can of mixed everything", false);       	
    set_auto_attack(0);
    use_skill($skill[Spirit of Cayenne]); //Hot
    adventure($location[Hobopolis Town Square], 1);
    use_skill($skill[Spirit of Peppermint]); //Cold
    adventure($location[Hobopolis Town Square], 1);
    use_skill($skill[Spirit of Garlic]); //Stinky
    adventure($location[Hobopolis Town Square], 1);
    use_skill($skill[Spirit of Wormwood]); //Spook
    adventure($location[Hobopolis Town Square], 1);
    use_skill($skill[Spirit of Bacon Grease]); //Sleaze
    adventure($location[Hobopolis Town Square], 1);
    use_skill($skill[Spirit of Nothing]); //Nothing
    maximize("weapon dmg, equip Li'l Businessman Kit, equip lucky gold ring, equip mafia thumb ring, equip cheeng's spectacles, equip can of mixed everything", false);
    set_auto_attack("Lunging Thrust-Smack");
    adventure($location[Hobopolis Town Square], 1);
    visit_url("clan_hobopolis.php?place=3&action=talkrichard&whichtalk=3&preaction=simulacrum&qty=1"); //Richard for scobo
    if ( contains_text( visit_url("clan_hobopolis.php?place=2") , "townsquare25o.gif") ) //After much testing, using the TownSquare image allows the loop to catch the opening of areas.
    {
        cli_execute( "mood apathetic" );
        set_auto_attack(0);                
        print ("Hodgman is now prepared.", "orange");
        break;
    }

    if (my_adventures() == 0)
    {
        cli_execute( "mood apathetic" );
        set_auto_attack(0);
        print ("You have ran out of adventures in the Town Square part 2.", "orange");
        exit;
    }


    } until ((last_choice() == 200));
    }
print ("Stage 8: Town Square Part 2 is complete. It is probably time to kill some bosses.", "orange");
//abort ( "Testing."); //For Testing
