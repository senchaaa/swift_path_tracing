import Foundation
import SwiftGD



func make_activity_graph(active: [Bool], output_file: String) {
    // figure out where to save our file
    let currentDirectory = URL(fileURLWithPath: FileManager().currentDirectoryPath)
    let destination = currentDirectory.appendingPathComponent(output_file)
    // example Color declaration
    // Color(red: Double(0.8), green: Double(0.4), blue: Double(0.7), alpha: 1)
    // attempt to create a new 500x500 image
    let WEEKS = 52
    let WEEKDAYS = 7
    // let's make each day a 3x3 pixel square
    let DAY_SIDE = 8
    // let's make the gap between them 2 pixels each
    let DAY_GAP = 5
    // we'll have 52 vertically stacked weeks
    // with 7 boxes each, each box will need 
    // WEEKS - 1 for teh space in between , then 2 * padding because we need padding on both sides
    let TOP_PADDING = 30
    let LEFT_PADDING = 30
    let WIDTH = (2 * LEFT_PADDING) + ((WEEKS - 1) * DAY_GAP) + (WEEKS * DAY_SIDE)
    let HEIGHT = (2 * TOP_PADDING) + ((WEEKDAYS - 1) * DAY_GAP) + (WEEKDAYS * DAY_SIDE)
    let CURRENT_DAY = 22
    if let image = Image(width: WIDTH, height: HEIGHT) {
        for col in 0 ..< WEEKS {
            for row in 0 ..< WEEKDAYS {
                // 0, 0 if the top left corner i believe
                let TOP_SIDE = TOP_PADDING + (row * DAY_SIDE) + (row * DAY_GAP)
                let LEFT_SIDE = LEFT_PADDING + (col * DAY_SIDE) + (col * DAY_GAP)
                let TOP_LEFT = Point(x: LEFT_SIDE, y: TOP_SIDE)
                let BOTTOM_RIGHT = Point(x: LEFT_SIDE + DAY_SIDE, y: TOP_SIDE + DAY_SIDE)
                let FILL_COLOR: Color
                let current_day_index = (col * WEEKDAYS) + row 
                if current_day_index < active.count && active[current_day_index] {
                    FILL_COLOR = Color.green
                } else {
                    FILL_COLOR = Color.white
                }
                image.fillRectangle(topLeft: TOP_LEFT, bottomRight: BOTTOM_RIGHT, color: FILL_COLOR)
            }
        }
        image.write(to: destination)
    }
}


func track_jp_progress(last_finished_chapter: Int, output_file: String) {
    let GENKI_1_CHAPTERS = 12
    let G1_CUT = GENKI_1_CHAPTERS
    let GENKI_2_CHAPTERS = 11
    let G2_CUT = GENKI_1_CHAPTERS + GENKI_2_CHAPTERS
    let QUARTET_1_CHAPTERS = 12
    let Q1_CUT = G2_CUT + QUARTET_1_CHAPTERS
    let QUARTET_2_CHAPTERS = 12
    let Q2_CUT = Q1_CUT + QUARTET_2_CHAPTERS
    let TOTAL_CHAPTERS = GENKI_1_CHAPTERS + GENKI_2_CHAPTERS + QUARTET_1_CHAPTERS + QUARTET_2_CHAPTERS
    let CHAPTER_HEIGHT = 30
    let BOOK_GAP = 20
    let TOP_PADDING = 50
    let LEFT_PADDING = 50
    let BOOK_WIDTH = 800
    
    let HEIGHT = (2 * TOP_PADDING) + (TOTAL_CHAPTERS * CHAPTER_HEIGHT)
    var curr_book_start = TOP_PADDING
    var curr_class_start = curr_book_start
    var curr_offset = TOP_PADDING + CHAPTER_HEIGHT
    var curr_class_offset = curr_offset
    // JAPN course information
    let J1_CUT = 8
    let J2_CUT = 16
    let J3_CUT = 23
    let J4_CUT = Q1_CUT
    let J5_CUT = Q2_CUT
    let BOOK_CLASS_GAP = 25
    let CLASS_LEFT = LEFT_PADDING + LEFT_PADDING + BOOK_WIDTH + BOOK_CLASS_GAP
    let CLASS_WIDTH = BOOK_WIDTH
    let CLASS_RIGHT = CLASS_LEFT + CLASS_WIDTH
    let CLASS_GAP = 16
    let WIDTH = CLASS_RIGHT + LEFT_PADDING//(2 * LEFT_PADDING) + BOOK_WIDTH
    let class_colors = [Color(red: 0.0, green: 0.7, blue: 0.7, alpha: 1.0),
                                Color(red: 0.4, green: 0.7, blue: 0.1, alpha: 1.0), 
                                Color(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0), 
                                Color(red: 0.5, green: 0.0, blue: 0.5, alpha: 1.0),
                                Color(red: 0.25, green: 0.25, blue: 0.85, alpha: 1.0)]
    let book_colors = [Color(red: 0.45, green: 0.7, blue: 0.2, alpha: 1.0),
                                Color(red: 0.14, green: 0.27, blue: 0.8, alpha: 1.0), 
                                Color(red: 0.1, green: 0.8, blue: 0.8, alpha: 1.0), 
                                Color(red: 0.6, green: 0.0, blue: 0.3, alpha: 1.0)]
    var class_index = 0
    var book_index = 0
    if let image = Image(width: WIDTH, height: HEIGHT) {
        for i in 1 ... TOTAL_CHAPTERS {
            
            if ([G1_CUT, G2_CUT, Q1_CUT, Q2_CUT].contains(i)) {
                // draw the current book as finished
                let TOP_LEFT = Point(x: LEFT_PADDING, y: curr_book_start)
                let BOTTOM_RIGHT = Point(x: LEFT_PADDING + 700, y: curr_offset)
                image.fillRectangle(topLeft: TOP_LEFT, bottomRight: BOTTOM_RIGHT, color: book_colors[book_index])
                curr_offset += BOOK_GAP
                curr_book_start = curr_offset
                book_index += 1
            }
            if ([J1_CUT, J2_CUT, J3_CUT, J4_CUT, J5_CUT].contains(i)) {
                // draw the current book as finished
                let TOP_LEFT = Point(x: CLASS_LEFT, y: curr_class_start)
                let BOTTOM_RIGHT = Point(x: CLASS_RIGHT, y: curr_class_offset)
                image.fillRectangle(topLeft: TOP_LEFT, bottomRight: BOTTOM_RIGHT, color: class_colors[class_index])
                curr_class_offset += CLASS_GAP
                curr_class_start = curr_class_offset
                class_index += 1
            }
            if i == last_finished_chapter {
                // draw progress line
                let TOP_LEFT = Point(x: LEFT_PADDING, y: curr_offset)
                let BOTTOM_RIGHT = Point(x: WIDTH - LEFT_PADDING, y: curr_offset)
                image.drawLine(from: TOP_LEFT, to: BOTTOM_RIGHT, color: Color.white)

            }
            curr_offset += CHAPTER_HEIGHT
            curr_class_offset += CHAPTER_HEIGHT

        }
        let currentDirectory = URL(fileURLWithPath: FileManager().currentDirectoryPath)
        let destination = currentDirectory.appendingPathComponent(output_file)
        image.write(to: destination)
    }

}


var activity_list: [Bool] = []

for i in 0 ..< 365 {
    let curr = Int.random(in: 1...2)
    activity_list.append(curr == 1)
}

make_activity_graph(active: activity_list, output_file: "activity_graph_2.png")
track_jp_progress(last_finished_chapter: 16, output_file: "jp_image.png")


// if let image = Image(width: 500, height: 500) {
    
//     // draw a filled green rectangle also in the center
//     image.fillRectangle(topLeft: Point(x: 200, y: 200), bottomRight: Point(x: 300, y: 300), color: Color.green)
    
//     // flood from from X:250 Y:250 using red
//     image.fill(from: Point(x: 250, y: 250), color: Color.green)

    
    
//     // draw a filled blue ellipse in the center
//     image.fillEllipse(center: Point(x: 250, y: 250), size: Size(width: 150, height: 150), color: Color.blue)
        
    

//     // remove all the colors from the image
//     // image.desaturate()
        
//     // now apply a dark red tint
//     //image.colorize(using: Color(red: 0.3, green: 0, blue: 0, alpha: 1))
        
//     // save the final image to disk
    
// }