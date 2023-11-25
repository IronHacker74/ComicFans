//
//  ErrorAlert.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/22/23.
//
import UIKit

protocol ErrorAlert: UIViewController {}

extension ErrorAlert {
    func presentErrorAlert() {
        Alert.ok(self, title: "Failed to load data.", message: "Something seemed to have gone wrong, we apologize please try again later.")
    }
}
