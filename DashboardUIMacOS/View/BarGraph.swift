//
//  BarGraph.swift
//  DashboardUIMacOS
//
//  Created by Volodymyr Pysarenko on 12.06.2024.
//

import SwiftUI

struct BarGraph: View {
    var downloads: [Download]
    var body: some View {
       
        VStack(spacing: 20){
            

            
            GraphView()
                .padding(.top, 20)
        }
        .padding(20)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.top)
    }
    
    @ViewBuilder
    func GraphView() -> some View {
        
        GeometryReader{ proxy in
            
            ZStack{
                
                VStack(spacing: 0){
                    
                    ForEach(getGraphLines(), id: \.self){ line in
                        
                        HStack(spacing: 8){
                            
                            Text("\(Int(line))")
                                .font(.caption)
                                .foregroundStyle(.gray)
                                .frame(height: 20)
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 1)
                        }
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .offset(y: -15)
                        
                    }
                }
                
                HStack{
                    
                    ForEach(downloads) { download in
                        
                        VStack(spacing: 0) {
                            
                            VStack(spacing: 5) {
                                
                                Rectangle()
                                    .fill(.black)
                            }
                            .frame(width: 30)
                            .frame(height: getBarHeight(point: download.downloads, size: proxy.size))
                            
                            Text(download.weekday)
                                .font(.caption )
                                .frame(height: 25, alignment: .bottom)
                                .foregroundStyle(.black)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    }
                }
                .padding(.leading, 30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .frame(height: 190)
    }
    
    func getBarHeight(point: CGFloat, size: CGSize) -> CGFloat {
        
        let max = getMax()
        
        let height = (point / max) * (size.height - 37)
        
        return height
    }
    
    func getGraphLines() -> [CGFloat] {
        let max = getMax()
        var lines: [CGFloat] = []
        lines.append(max)
        
        for index in 1...4{
            let progress = max / 4
            lines.append(max - (progress * CGFloat(index)))
        }
        return lines
    }
    
    func getMax() -> CGFloat {
        let max = downloads.max { first, second in
            return second.downloads > first.downloads
        }?.downloads ?? 0
        
        return max
    }
}

#Preview {
    BarGraph(downloads: downloads)
}
