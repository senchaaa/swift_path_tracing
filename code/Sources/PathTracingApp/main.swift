import Foundation
//import SIMD

// define what scene i want to parse
let scene_to_parse = "example_scenes/CornellBox.xml"
// parse the scene from the file into a scene object

// create a pathtracer object
// give it the scene object

// struct Vector3 {
//     let x: Float
//     let y: Float
//     let z: Float
// }

typealias Vector3 = simd_float3

let IMAGE_ROWS = 500
let IMAGE_COLS = 500

// TODO: make a 2d array for placing the pixels?
// or the irradiance at each point

for y in (0 ..< IMAGE_ROWS) {
    for x in (0 ..< IMAGE_COLS) {

    }
}

// this gets the irradiance value of a pixel at x, y
// by figuring out the ray of the pixel and then tracing it
func tracePixel(x: Int, y: Int,  scene: Scene, inViewMatrix: simd_float4x4) -> Vector3 {
    let origin = Vector3(x: 0.0, y: 0.0, z: 0.0)
    let dX: Float = (2.0 * Float(x) / Float(IMAGE_COLS)) - 1.0 
    let dY: Float = 1.0 - (2.0 * Float(y) / Float(IMAGE_ROWS))
    let dZ: Float = -1.0
    let d = normalize(Vector3([dX, dY, dZ]))
    let ray = Ray(origin: origin, dest: d)
    let r = ray.transform(inViewMatrix)
    return traceRay(r, scene)

}

// this actually follows the ray in the scene to determine
// where it intersects and what light sources might be there
// you know how it goes
func traceRay(ray: Ray, scene: Scene) -> Vector3 {
    let intersectionInfo = scene.getIntersection(ray)
    if intersectionInfo.isImpact {

    } else {
        return Vector3([0.0, 0.0, 0.0])
    }
}

// then go across each row and column each x and y
// determine the ray of that x and y
// then trace that ray
// and that will give me a color
