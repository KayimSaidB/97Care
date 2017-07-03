
pragma solidity ^0.4.11;
contract assurance_test{
    
    uint256 prix=500000;
    uint256 tresorerie=0;
    uint [3] tableauprix;
    function initialiser_prix(uint [3]tableau_prix){
        tableauprix=tableau_prix;
    }
    
   
    mapping (address => bool[3]) registre_assure; /// indique si une personne est dans le registre
    /// tableau de boolens pour indiquer si elle a payé ses droits , on peut imaginer un tableau plus grand

    mapping (address => uint256) compte_assure; /// permet à l'assuré d'avoir un compte avec lequel il peut souscrire a une assurance et se faire rembourser 
    mapping (address => bool) registre_specialiste; // registre des personnes qui peuvent valider une déclartion de sinistre
    /// les déclarations de sinistre
    // pour gérer différents types de prestations
    function adhesion() returns (bool){
    
        if (registre_assure[msg.sender][0]==false){ registre_assure[msg.sender][0]=true;
            return true;
        }
        
        else 
        return false;
        }
        event show(bytes32 message);
    function ajouter_specialiste(address nouveau){
        bytes32 message="Love is the answer";
        registre_specialiste[nouveau]=true;
        show(message);
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
    if (compte_assure[msg.sender]>=tableauprix[choix_assurance]){
        tresorerie+=tableauprix[choix_assurance];
        compte_assure[msg.sender]-=tableauprix[choix_assurance];
        registre_assure[msg.sender][choix_assurance]=true;
        return true;
    }
        
    else return false;
        
    }
    

    function get_tresorerie() returns (uint){
        return tresorerie;
    }

    function declaration_sinistre_apres_validation(uint reference_sinistre) returns (bool){
    if (registre_sinistre[reference_sinistre].est_valide==true && tresorerie>=registre_sinistre[reference_sinistre].valeur_sinistre){
        compte_assure[msg.sender]+=registre_sinistre[reference_sinistre].valeur_sinistre;
        tresorerie-=registre_sinistre[reference_sinistre].valeur_sinistre;
        return true;
    }
    return false;
    }


    
    
    
}
