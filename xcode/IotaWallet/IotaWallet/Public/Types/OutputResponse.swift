import Foundation

struct OutputResponse: Codable {
    /// The actual Output.
    var output: Output?
    /// The metadata of the output.
    var metadata: OutputMetadata?
}
