pragma solidity ^0.4.11;

/// tokens parts sociales
import "./datatime.sol";
contract budget is DateTime {
    


uint nb_produit;
 uint nb_charges;
 uint value_charges;
 uint value_produit;
 uint nb_active;
 uint nb_passive;
 uint value_active;
 uint value_passive;
 mapping (string => uint) active; 
 mapping(uint => string) active_index;
 mapping (string =>uint )passive;
 mapping(uint => string) passive_index;
 mapping(string => uint) registre_produit;
 mapping (uint => string) index_produits;
  mapping(string => uint) registre_charges;
 mapping (uint => string) index_charges;
 function register_a_new_active(uint valeur, string nom){
     active[nom]=valeur;
    active_index[nb_active]=nom;

     nb_active++;
     value_active+=valeur;
     
 }
  function register_a_new_passsive(uint valeur, string nom){
     passive[nom]=valeur;
     passive_index[nb_passive]=nom;
     nb_passive++;
     value_passive+=valeur;
 }

 /// verify if the value of active is equal to the value of passive
 function is_count_right() returns (bool){
     return (value_passive==value_active);
 }

event show(string assive,uint valeur);
event temps( uint massive);
function show_active() {
    uint i=0;
    for (i=0;i<nb_active;i++){
        show(active_index[i],active[active_index[i]]);
    }

    
}
function show_passive() {
    uint i=0;
    for (i=0;i<nb_passive;i++){
        show(passive_index[i],passive[passive_index[i]]);
    }
    
    }
event show_date_and_hour(uint16[6]);

function bilan_financier(){
   /// corresponds to the block timestamp of the transaction
    show_passive();
    show_active();
    show_date_and_hour([getDay(now),getMonth(now),getYear(now),getHour(now),getMinute(now),getSecond(now)]);
}

mapping(address => uint) register_of_social_part;    
uint totalnumberpart;
function register_a_social_part(address newowner,uint numberpart)  {
    register_of_social_part[newowner]=numberpart;
    totalnumberpart+=numberpart;
    
}   

function register_a_new_product(uint valeur, string nom){
     registre_produit[nom]=valeur;
     index_produits[nb_produit]=nom;
     nb_produit++;
     value_produit+=valeur;
 }
 function register_a_new_charge(uint valeur, string nom){
     registre_charges[nom]=valeur;
     index_charges[nb_produit]=nom;
     nb_produit++;
     value_charges+=valeur;
 }
 struct a_divide { 
     bool has_started;
    mapping(address => bool) has_get_parts;
    uint benefit_to_share;
 }
mapping (uint16 => a_divide) register_divide;
uint report_benefices;
 function start_divide_benefit(uint benefit_to_share) returns (bool){
     
     uint benefices=value_produit-value_charges;
     if (benefices>benefit_to_share){
         register_divide[getYear(now)].has_started=true;
         register_divide[getYear(now)].benefit_to_share=benefit_to_share;
         report_benefices=benefices-benefit_to_share;
         return true;
     }
     else 
     return false;
 }
  
function give_the_part(address investor ) { 
    if (register_divide[getYear(now)].has_started==true && register_divide[getYear(now)].has_get_parts[investor]==false){
    investor.transfer((register_divide[getYear(now)].benefit_to_share*register_of_social_part[investor])/totalnumberpart);     
    register_divide[getYear(now)].has_get_parts[investor]=true;
    }
    
    
}

    
}