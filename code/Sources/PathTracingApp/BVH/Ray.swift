import Foundation

struct Ray {
    var origin: Vector3
    var dest: Vector3 
    func transform(simd_float4x4) -> Vector3 {
        return Vector3([0.0, 0.0, 0.0])
    }
}