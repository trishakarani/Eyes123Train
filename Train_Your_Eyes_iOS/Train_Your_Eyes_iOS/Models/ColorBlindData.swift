//
//  ColorBlindData.swift
//  Train_Your_Eyes_iOS
//
//  Created by Trisha Karani on 11/18/18.
//  Copyright © 2018 Eyes123Train. All rights reserved.
//

import Foundation

struct ColorBlindData {
    
    var imgName: String
    var correctIdx : Int
    var choices: [String]
}

let Plate1  = ColorBlindData(imgName: "Plate1",  correctIdx: 2, choices: ["21", "11", "12", "none"])
let Plate2  = ColorBlindData(imgName: "Plate2",  correctIdx: 2, choices: ["none", "6", "8", "80"])
let Plate3  = ColorBlindData(imgName: "Plate3",  correctIdx: 2, choices: ["9", "none", "29", "49"])
let Plate4  = ColorBlindData(imgName: "Plate4",  correctIdx: 2, choices: ["3", "7", "5", "none"])
let Plate5  = ColorBlindData(imgName: "Plate5",  correctIdx: 2, choices: ["2", "none", "3", "9"])
let Plate6  = ColorBlindData(imgName: "Plate6",  correctIdx: 2, choices: ["none", "11", "15", "51"])
let Plate7  = ColorBlindData(imgName: "Plate7",  correctIdx: 2, choices: ["47", "none", "74", "34"])
let Plate8  = ColorBlindData(imgName: "Plate8",  correctIdx: 2, choices: ["3", "9", "6", "none"])
let Plate9  = ColorBlindData(imgName: "Plate9",  correctIdx: 2, choices: ["25", "none", "45", "54"])
let Plate10 = ColorBlindData(imgName: "Plate10", correctIdx: 2, choices: ["none", "50", "5", "1"])
let Plate11 = ColorBlindData(imgName: "Plate11", correctIdx: 2, choices: ["5", "3", "7", "none"])
let Plate12 = ColorBlindData(imgName: "Plate12", correctIdx: 2, choices: ["6", "none", "16", "12"])
let Plate13 = ColorBlindData(imgName: "Plate13", correctIdx: 2, choices: ["none", "37", "73", "7"])
let Plate14 = ColorBlindData(imgName: "Plate14", correctIdx: 2, choices: ["35", "3", "none", "63"])
let Plate15 = ColorBlindData(imgName: "Plate15", correctIdx: 2, choices: ["31", "5", "none", "22"])
let Plate16 = ColorBlindData(imgName: "Plate16", correctIdx: 2, choices: ["none", "62", "26", "6"])
let Plate17 = ColorBlindData(imgName: "Plate17", correctIdx: 2, choices: ["2", "4", "42", "none"])
let Plate18 = ColorBlindData(imgName: "Plate18", correctIdx: 2, choices: ["84", "68", "none", "31"])
let Plate19 = ColorBlindData(imgName: "Plate19", correctIdx: 2, choices: ["37", "4", "none", "62"])
let Plate20 = ColorBlindData(imgName: "Plate20", correctIdx: 2, choices: ["29", "47", "none", "59"])
let Plate21 = ColorBlindData(imgName: "Plate21", correctIdx: 2, choices: ["71", "35", "none", "95"])
let Plate22 = ColorBlindData(imgName: "Plate22", correctIdx: 2, choices: ["18", "88", "none", "89"])
let Plate23 = ColorBlindData(imgName: "Plate23", correctIdx: 2, choices: ["34", "74", "none", "77"])
let Plate24 = ColorBlindData(imgName: "Plate24", correctIdx: 2, choices: ["54", "64", "none", "19"])
let Plate25 = ColorBlindData(imgName: "Plate25", correctIdx: 2, choices: ["F", "A", "O", "Z"])
let Plate26 = ColorBlindData(imgName: "Plate26", correctIdx: 2, choices: ["number", "Bird", "Flower", "none"])
let Plate27 = ColorBlindData(imgName: "Plate27", correctIdx: 2, choices: ["Flower", "none", "Butterfly", "Bird"])
let Plate28 = ColorBlindData(imgName: "Plate28", correctIdx: 2, choices: ["none", "0", "8", "18"])
let Plate29 = ColorBlindData(imgName: "Plate29", correctIdx: 2, choices: ["O", "none", "C", "0"])
let Plate30 = ColorBlindData(imgName: "Plate30", correctIdx: 2, choices: ["2", "4", "42", "none"])
let Plate31 = ColorBlindData(imgName: "Plate31", correctIdx: 2, choices: ["none", "5", "57", "37"])
let Plate32 = ColorBlindData(imgName: "Plate32", correctIdx: 2, choices: ["0", "none", "8", "6"])

var colorBlindNumberSet =
    [1: Plate1, 2: Plate2, 3: Plate3, 4: Plate4, 5: Plate5, 6: Plate6, 7: Plate7, 8: Plate8, 9: Plate9, 10:Plate10, 11: Plate11, 12: Plate12, 13: Plate13, 14: Plate16, 15: Plate17, 16: Plate25, 17: Plate28, 18: Plate29, 19: Plate30, 20: Plate31, 21: Plate32]

var colorBlindNothingSet =
    [1: Plate14, 2: Plate15, 3: Plate18, 4: Plate19, 5: Plate20, 6: Plate21, 7: Plate22, 8: Plate23, 9: Plate24]
