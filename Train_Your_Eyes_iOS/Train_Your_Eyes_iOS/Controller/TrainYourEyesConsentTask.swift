//
//  TrainYourEyesConsentTask.swift
//  Train_Your_Eyes_iOS
//
//  Created by Trisha Karani on 7/22/19.
//  Copyright © 2019 Eyes123Train. All rights reserved.
//

import Foundation
import ResearchKit

public var TrainYourEyesConsentTask: ORKOrderedTask {
    
    let Document = ORKConsentDocument()
    Document.title = "Test Consent"
    
    let sectionTypes: [ORKConsentSectionType] = [
        .overview,
        //.dataGathering,
        .privacy,
        //.dataUse,
        .timeCommitment,
        //.studySurvey,
        .studyTasks,
       // .withdrawing
    ]
    
    let consentSections: [ORKConsentSection] = sectionTypes.map { contentSectionType in
        let consentSection = ORKConsentSection(type: contentSectionType)
        consentSection.summary = "Eye Q - Train Your Eyes"
        consentSection.content = "This app focuses on eye and brain training exercises. Data is collected for app improvement purposes only."
        return consentSection
    }
    
    Document.sections = consentSections
    Document.addSignature(ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "UserSignature"))
    
    var steps = [ORKStep]()
    
   //Visual Consent
    let visualConsentStep = ORKVisualConsentStep(identifier: "VisualConsent", document: Document)
    steps += [visualConsentStep]
    
    //Signature
    let signature = Document.signatures!.first! as ORKConsentSignature
    let reviewConsentStep = ORKConsentReviewStep(identifier: "Review", signature: signature, in: Document)
    reviewConsentStep.text = "Review the consent"
    reviewConsentStep.reasonForConsent = "Consent to Begin."
    
    steps += [reviewConsentStep]
    
    //Completion
    let completionStep = ORKCompletionStep(identifier: "CompletionStep")
    completionStep.title = "Welcome"
    completionStep.text = "Thanks for joining!"
    steps += [completionStep]
    
    return ORKOrderedTask(identifier: "TrainYourEyesConsentTask", steps: steps)
}
