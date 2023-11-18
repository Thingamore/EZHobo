//Step 1: Speed through sewers
string town_map = visit_url("clan_hobopolis.php?place=2") ;
if ( contains_text( town_map , "clan_hobopolis.php?place=3") )
    {
    print ("The Maze of Sewer Tunnels is already clear.", "orange") ;
    }
    else
    {
    set_property( "choiceAdventure198" , "1"); //Disgustin' Junction, Sewer Tunnel
    set_property( "choiceAdventure197" , "1"); //Somewhat Higher and Mostly Dry, Sewer Tunnel
    set_property( "choiceAdventure199" , "1"); //The Former or the Ladder, Sewer Tunnel
    set_property( "choiceAdventure211" , "1"); //Caging, gnaw bars (ASSBot should be in place though)
    set_property( "choiceAdventure212" , "1"); //Caging, gnaw bars (ASSBot should be in place though)    
    if( have_familiar($familiar[Disgeist]) && my_familiar() != $familiar[Disgeist] )
        {
        use_familiar($familiar[Disgeist]);
        }
    cli_execute( "maximize -combat, equip hobo code binder, equip gatorskin umbrella" );
    cli_execute( "set customCombatScript = FreeRun;" );
    while (get_property("lastEncounter") != "At Last!")
        {	
        if (my_adventures() == 0)
            {
            cli_execute( "mood apathetic" );
            print ("You have ran out of adventures in the Maze of Sewers Tunnels.") ;
            exit;
            }

        foreach it in $items[unfortunate dumplings, sewer wad, bottle of Ooze-O]
        {
        if(item_amount(it) < 1)
        buy(1 , it);
        }

        if(item_amount($item[gatorskin umbrella]) < 1)
        buy(1 , $item[gatorskin umbrella]);

        if(item_amount($item[oil of oiliness]) < 3)
        buy(3 , $item[oil of oiliness]);            
        adventure(1, $location[a maze of sewer tunnels]) ;
        }
    set_auto_attack(0);    
    print("You have cleared the Maze of Sewer Tunnels.", "orange");    
    }
//abort ( "Testing."); //For Testing
