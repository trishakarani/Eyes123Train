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

let Plate1  = ColorBlindData(imgName: "Plate1",  correctIdx: 2, choices: ["21", "11", "12", "nothing"])
let Plate2  = ColorBlindData(imgName: "Plate2",  correctIdx: 2, choices: ["nothing", "6", "8", "80"])
let Plate3  = ColorBlindData(imgName: "Plate3",  correctIdx: 2, choices: ["9", "nothing", "29", "49"])
let Plate4  = ColorBlindData(imgName: "Plate4",  correctIdx: 2, choices: ["3", "7", "5", "nothing"])
let Plate5  = ColorBlindData(imgName: "Plate5",  correctIdx: 2, choices: ["2", "nothing", "3", "9"])
let Plate6  = ColorBlindData(imgName: "Plate6",  correctIdx: 2, choices: ["nothing", "11", "15", "51"])
let Plate7  = ColorBlindData(imgName: "Plate7",  correctIdx: 2, choices: ["47", "nothing", "74", "34"])
let Plate8  = ColorBlindData(imgName: "Plate8",  correctIdx: 2, choices: ["3", "9", "6", "nothing"])
let Plate9  = ColorBlindData(imgName: "Plate9",  correctIdx: 2, choices: ["25", "nothing", "45", "54"])
let Plate10 = ColorBlindData(imgName: "Plate10", correctIdx: 2, choices: ["nothing", "50", "5", "1"])
let Plate11 = ColorBlindData(imgName: "Plate11", correctIdx: 2, choices: ["5", "3", "7", "nothing"])
let Plate12 = ColorBlindData(imgName: "Plate12", correctIdx: 2, choices: ["6", "nothing", "16", "12"])
let Plate13 = ColorBlindData(imgName: "Plate13", correctIdx: 2, choices: ["nothing", "37", "73", "7"])
let Plate14 = ColorBlindData(imgName: "Plate14", correctIdx: 2, choices: ["35", "3", "nothing", "63"])
let Plate15 = ColorBlindData(imgName: "Plate15", correctIdx: 2, choices: ["31", "5", "nothing", "22"])
let Plate16 = ColorBlindData(imgName: "Plate16", correctIdx: 2, choices: ["nothing", "62", "26", "6"])
let Plate17 = ColorBlindData(imgName: "Plate17", correctIdx: 2, choices: ["2", "4", "42", "nothing"])
let Plate18 = ColorBlindData(imgName: "Plate18", correctIdx: 2, choices: ["84", "68", "nothing", "31"])
let Plate19 = ColorBlindData(imgName: "Plate19", correctIdx: 2, choices: ["37", "4", "nothing", "62"])
let Plate20 = ColorBlindData(imgName: "Plate20", correctIdx: 2, choices: ["29", "47", "nothing", "59"])
let Plate21 = ColorBlindData(imgName: "Plate21", correctIdx: 2, choices: ["71", "35", "nothing", "95"])
let Plate22 = ColorBlindData(imgName: "Plate22", correctIdx: 2, choices: ["18", "88", "nothing", "89"])
let Plate23 = ColorBlindData(imgName: "Plate23", correctIdx: 2, choices: ["34", "74", "nothing", "77"])
let Plate24 = ColorBlindData(imgName: "Plate24", correctIdx: 2, choices: ["54", "64", "nothing", "19"])
let Plate25 = ColorBlindData(imgName: "Plate25", correctIdx: 2, choices: ["F", "A", "O", "Z"])
let Plate26 = ColorBlindData(imgName: "Plate26", correctIdx: 2, choices: ["number", "Bird", "Flower", "nothing"])
let Plate27 = ColorBlindData(imgName: "Plate27", correctIdx: 2, choices: ["Flower", "nothing", "Butterfly", "Bird"])
let Plate28 = ColorBlindData(imgName: "Plate28", correctIdx: 2, choices: ["nothing", "0", "8", "18"])
let Plate29 = ColorBlindData(imgName: "Plate29", correctIdx: 2, choices: ["O", "nothing", "C", "0"])
let Plate30 = ColorBlindData(imgName: "Plate30", correctIdx: 2, choices: ["2", "4", "42", "nothing"])
let Plate31 = ColorBlindData(imgName: "Plate31", correctIdx: 2, choices: ["nothing", "5", "57", "37"])
let Plate32 = ColorBlindData(imgName: "Plate32", correctIdx: 2, choices: ["0", "nothing", "8", "6"])

var colorBlindNumberSet =
    [1: Plate1, 2: Plate2, 3: Plate3, 4: Plate4, 5: Plate5, 6: Plate6, 7: Plate7, 8: Plate8, 9: Plate9, 10:Plate10, 11: Plate11, 12: Plate12, 13: Plate13, 14: Plate16, 15: Plate17, 16: Plate25, 17: Plate26, 18: Plate27, 19: Plate28, 20: Plate29, 21: Plate30, 22: Plate31, 23: Plate32]

var colorBlindNothingSet =
    [1: Plate14, 2: Plate15, 3: Plate18, 4: Plate19, 5: Plate20, 6: Plate21, 7: Plate22, 8: Plate23, 9: Plate24]
