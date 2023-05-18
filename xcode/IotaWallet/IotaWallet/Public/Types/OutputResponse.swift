import Foundation

struct OutputResponse: Codable {
    /// The actual Output.
    var output: OutputWrapper?
    /// The metadata of the output.
    var metadata: OutputMetadata?
}
