//
//  MainVC.swift
//  Pong
//
//  Created by Auriel on 3/7/17.
//  Copyright © 2017 Sphexis. All rights reserved.
//

import Foundation
import UIKit

/** Basic Game Types
 - easy: easy game
 - medium: normal game type
 - hard: hard difficuly
 - player2: main player
 **/

enum gameType {
    case easy
    case medium
    case hard
    case player2
}


class MenuVC: UIViewController {
    
    @IBAction func Player2(_sender: Any) {
        moveToGame(game: .player2)
    }
    
    @IBAction func Easy(_sender: Any) {
        moveToGame(game: .easy)
    }
    
    @IBAction func Medium(_sender: Any) {
        moveToGame(game: .medium)
    }
    
    @IBAction func Hard(_sender: Any) {
        moveToGame(game: .hard)
    }
    
    func moveToGame(game : gameType) {
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        
        currentGameType = game
        
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
    
}
