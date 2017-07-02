pragma solidity ^0.4.11;
contract assurance_test{
    
    uint256 prix=5000;
    uint256 tresorerie=0;
    
   
    mapping (address => bool[3]) registre_assure; /// indique si une personne est dans le registre
    mapping (address => uint256) compte_assure;
    mapping (address => bool) registre_specialiste; // registre des personnes qui valident
    /// les déclarations de sinistre
    /// tableau de boolens pour indiquer si elle a payé ses droits , on peut imaginer un tableau plus grand
    // pour gérer différents types de prestations
    function adhesion() returns (bool){
    
        if (registre_assure[msg.sender][0]==false){ registre_assure[msg.sender][0]=true;
            return true;
        }
        
        else 
        return false;
        }
    function ajouter_specialiste(address nouveau){
        
        registre_specialiste[nouveau]=true;
    }

    struct un_sinistre{
        uint type_sinistre;
        uint valeur_sinistre;
        bool est_valide;
    }
    mapping (uint256 => un_sinistre) registre_sinistre; // chaque sinistre va etre reconnu par un id
    function recharger_compte() payable{
        compte_assure[msg.sender]+=msg.value;
    }
    function check_compte()returns (uint){
        return compte_assure[msg.sender];
    }
    uint compteur_sinistre=1;
    function declaration_sinistre_au_specialiste(uint type_sinistre,uint valeur_sinistre) returns (bool){
        if (registre_assure[msg.sender][type_sinistre]==true){
            registre_sinistre[compteur_sinistre].type_sinistre=type_sinistre;
            registre_sinistre[compteur_sinistre].valeur_sinistre=valeur_sinistre;
            compteur_sinistre++;
            return true;
            }
        else 
        return false;
    }
    
    function validation_specialiste(uint reference_sinistre, bool choix) returns (bool){
        if (registre_specialiste[msg.sender]==true) registre_sinistre[reference_sinistre].est_valide=choix;
        return choix;
    }
    function cotisation(uint choix_assurance) payable returns (bool){
    if (compte_assure[msg.sender]>=prix){
        tresorerie+=prix;
        compte_assure[msg.sender]-=prix;
        registre_assure[msg.sender][choix_assurance]=true;
        return true;
    }
        
    else return false;
        
    }
    

    function get_tresorerie() returns (uint){
        return tresorerie;
    }

    function declaration_sinistre_apres_validation(uint reference_sinistre){
    if (registre_sinistre[reference_sinistre].est_valide==true && tresorerie>=registre_sinistre[reference_sinistre].valeur_sinistre){
        compte_assure[msg.sender]+=registre_sinistre[reference_sinistre].valeur_sinistre;
        tresorerie-=registre_sinistre[reference_sinistre].valeur_sinistre;
    }
    }


    
    
    
    
    
    
    
    
}
