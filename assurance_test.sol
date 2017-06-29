pragma solidity ^0.4.11;
contract assurance_test{
    
    uint256 prix=5000;
    uint256 tresorerie=0;
    
   
    mapping (address => bool[3]) registre_assure; /// indique si une personne est dans le registre
    mapping (address => uint256) compte_assure;
    /// tableau de boolens pour indiquer si elle a payé ses droits , on peut imaginer un tableau plus grand
    // pour gérer différents types de prestations
    function adhesion() returns (bool){
    
        if (registre_assure[msg.sender][0]==false){ registre_assure[msg.sender][0]=true;
            return true;
        }
        
        else 
        return false;
        }
    
    function recharger_compte() payable{
        compte_assure[msg.sender]+=msg.value;
    }
    function check_compte()returns (uint){
        return compte_assure[msg.sender];
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

    function declaration_sinistre_apres_validation(uint type_sinistre, uint valeur_sinistre){
    if (registre_assure[msg.sender][type_sinistre]==true && tresorerie>=valeur_sinistre){
        compte_assure[msg.sender]+=valeur_sinistre;
        tresorerie-=valeur_sinistre;
    }
    }


    
    
    
    
    
    
    
    
}
