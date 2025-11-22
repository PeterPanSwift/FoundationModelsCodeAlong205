import Foundation
import FoundationModels
import Observation

@Observable
@MainActor
final class ItineraryGenerator {
    
    var error: Error?
    let landmark: Landmark
    
    private var session: LanguageModelSession
    
    private(set) var itinerary: Itinerary.PartiallyGenerated?
    
    // MARK: - [CODE-ALONG] Chapter 5.3.1: Add a property to hold the tool
    
    
    init(landmark: Landmark) {
        self.landmark = landmark
        let instructions = Instructions {
            "Your job is to create an itinerary for the user."
            "For each day, you must suggest one hotel and one restaurant."
        }
        self.session = LanguageModelSession(instructions: instructions)
        
        
        // MARK: - [CODE-ALONG] Chapter 5.3.2: Initialize LanguageModelSession with Tool
        
    }
    
    func generateItinerary(dayCount: Int = 3) async {
        do {
            let prompt = Prompt {
                "Generate a \(dayCount)-day itinerary to \(landmark.name)."
                "Give it a fun title and description."
                "Here is an example of the desired format, but don't copy its content:"
                Itinerary.exampleTripToJapan
            }
            let stream = session.streamResponse(to: prompt,
                                                generating: Itinerary.self)
            for try await partialResponse in stream {
                self.itinerary = partialResponse.content
            }
        } catch {
            self.error = error
        }
        // MARK: - [CODE-ALONG] Chapter 5.3.1: Update the instructions to use the Tool
        // MARK: - [CODE-ALONG] Chapter 5.3.2: Update the LanguageModelSession with the tool
        // MARK: - [CODE-ALONG] Chapter 6.2.1: Update to exclude schema in prompt
        
    }
    
    func prewarmModel() {
        // MARK: - [CODE-ALONG] Chapter 6.1.1: Add a function to pre-warm the model
    }
}
