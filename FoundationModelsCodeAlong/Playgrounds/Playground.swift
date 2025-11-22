import FoundationModels
import Playgrounds

#Playground {
    let instructions = """
        Your job is to create an itinerary for the user.
        """
    
    let session = LanguageModelSession(instructions: instructions)
    let prompt = "Generate a 3-day itinerary to Paris."
    let response = try await session.respond(to: prompt,
                                             generating: SimpleItinerary.self)
}

// The @Generable macro makes your custom type compatible with the model.
@Generable
struct SimpleItinerary {
    // The @Guide macro provides hints to the model about a property.
    @Guide(description: "An exciting name for the trip.")
    let title: String
    
    @Guide(description: "A short, engaging description of the trip.")
    let description: String
    
    @Guide(description: "A list of day-by-day plans, as simple strings.")
    @Guide(.count(3))
    let days: [String]
}

#Playground {
    let instructions = """
        Your job is to create an itinerary for the user.
        """
    
    let session = LanguageModelSession(instructions: instructions)
    let prompt = "Generate a 3-day itinerary to the Grand Canyon."
    let response = try await session.respond(to: prompt,
                                             generating: Itinerary.self)
}

#Playground {
    let instructions = "Your job is to create an itinerary for the user."
    let session = LanguageModelSession(instructions: instructions)
    
    let kidFriendly = true
    
    // The Prompt builder allows for conditional logic.
    let prompt = Prompt {
        "Generate a 3-day itinerary to the Grand Canyon."
        if kidFriendly {
            "The itinerary must be kid-friendly."
        }
    }
    
    let response = try await session.respond(
        to: prompt,
        generating: Itinerary.self
    )
}

#Playground {
    let instructions = "Your job is to create an itinerary for the user."
    let session = LanguageModelSession(instructions: instructions)
    
    let kidFriendly = false
    
    // Use the Prompt builder to combine your request with an example.
    let prompt = Prompt {
        "Generate a 3-day itinerary to the Grand Canyon."
        if kidFriendly {
            "The itinerary must be kid-friendly."
            "Here is an example of the desired format, but don't copy its content:"
            Itinerary.exampleTripToJapan
        }
    }
    
    let response = try await session.respond(to: prompt,
                                             generating: Itinerary.self)
}
