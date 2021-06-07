import Foundation

final class FillWithColor {
    
    func fillWithColor(_ image: [[Int]], _ row: Int, _ column: Int, _ newColor: Int) -> [[Int]] {
        var image = image
        if (image.isEmpty || image.count == 0) {
            return [[]]
        }
        
        let cellValue: Int = image[row][column]
        let i = row
        let j = column
                //if (image[i][j] == cellValue){
        stepping(&image, i, j, newColor, cellValue)
               // }
            //}
        //}
        return image
    }
    func stepping(_ image:inout [[Int]], _ i: Int, _ j: Int, _ newColor: Int, _ cellValue: Int){
        
        if (i<0 || i > image.count || i == image.count || j<0 || j > image[i].count || j == image[i].count || image[i][j] != cellValue || image[i][j] == newColor){
            return
        }
        image[i][j] = newColor
        stepping(&image, i, j+1, newColor, cellValue)
        stepping(&image, i+1, j, newColor, cellValue)
        stepping(&image, i, j-1, newColor, cellValue)
        stepping(&image, i-1, j, newColor, cellValue)
    }
}
