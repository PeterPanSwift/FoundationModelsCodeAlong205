/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A Playground for testing Foundation Models framework features.
*/

import FoundationModels
import Playgrounds

#Playground {
    let instructions = """
        Your job is to create an itinerary for the user.
        Each day needs an activity, hotel and restaurant.
        
        Always include a title, a short description, and a day-by-day plan.
        """
    
    let session = LanguageModelSession(instructions: instructions)
    let response = try await session.respond(to: "Generate a 3-day itinerary to Paris.")
}

#Playground {
    let instructions = """
        Your job is to create an itinerary for the user.
        Each day needs an activity, hotel and restaurant.
        
        Always include a title, a short description, and a day-by-day plan.
        """
    
    let session = LanguageModelSession(instructions: instructions)
    let response = try await session.respond(to: "Generate a 3-day itinerary to Paris.")
}

