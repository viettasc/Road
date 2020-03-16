//
//  ContentView.swift
//  Road
//
//  Created by Viettasc on 1/23/20.
//  Copyright © 2020 Viettasc. All rights reserved.
//

import SwiftUI

typealias Road = (position: Int, next: Int, lengh: Int)
typealias Return = (locations: [Int], lengh: Int)

struct ContentView: View {
    
    @State var solution: Return = ([], 0)
    var random: Int { Int.random(in: 1...10) }
    
    var title: some View {
        Text("Road - Viettasc!")
            .onAppear {
                var solution: Return = ([], 0)
                var roads: [Road] = self.initialize()
                print("road count: ", roads.count)
                self.find(roads: &roads, solution: &solution)
                print("solution: ", solution)
                print("road count: ", roads.count)
        }
    }
    
    var body: some View {
        ZStack {
            Color.pink.opacity(0.1)
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 20) {
                title
                    .font(.largeTitle)
                Image("tyemtee")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .padding()
                Text("the fastest way to go to 15 from 0 is:")
                Text("\(text(value: solution)) km")
                Image("road")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Capsule())
            }
            .foregroundColor(Color.pink)
            .padding()
        }
    }
    
    func initialize() -> [Road] {
        var roads: [Road] = []
        //
        //          -> 9
        //      -> 3    -> 11
        //  -> 1    -> 6    -> 13
        // 0    -> 4    -> 8     -> 15
        //  -> 2    -> 7    -> 14
        //      -> 5    -> 12
        //          -> 10
        //
        //
        //            -> 9
        //        -> 3    -> 11
        //    -> 1    -> 6    -> 13
        //-> 0   -> 4             -> 15
        //    -> 2    -> 7    -> 14
        //        -> 5    -> 12
        //            -> 10
        //
        roads.append((position: 0, next: 1, lengh: self.random))
        roads.append((position: 0, next: 2, lengh: self.random))
        roads.append((position: 1, next: 3, lengh: self.random))
        roads.append((position: 1, next: 4, lengh: self.random))
        roads.append((position: 2, next: 4, lengh: self.random))
        roads.append((position: 2, next: 5, lengh: self.random))
        roads.append((position: 3, next: 6, lengh: self.random))
        roads.append((position: 3, next: 9, lengh: self.random))
        roads.append((position: 4, next: 6, lengh: self.random))
        roads.append((position: 4, next: 7, lengh: self.random))
        roads.append((position: 5, next: 7, lengh: self.random))
        roads.append((position: 5, next: 10, lengh: self.random))
        //                roads.append((position: 6, next: 8, lengh: self.random))
        //                roads.append((position: 7, next: 8, lengh: self.random))
        roads.append((position: 7, next: 12, lengh: self.random))
        //                roads.append((position: 7, next: 8, lengh: self.random))
        //                roads.append((position: 8, next: 13, lengh: self.random))
        //                roads.append((position: 8, next: 14, lengh: self.random))
        roads.append((position: 9, next: 11, lengh: self.random))
        roads.append((position: 10, next: 12, lengh: self.random))
        roads.append((position: 11, next: 13, lengh: self.random))
        roads.append((position: 12, next: 14, lengh: self.random))
        roads.append((position: 13, next: 15, lengh: self.random))
        roads.append((position: 14, next: 15, lengh: self.random))
        return roads
    }
    
    func text(value: Return) -> String {
        return "\(value)"
    }
    
    // tracking location
    func brand(location: [Int], roads: [Road]) -> Int {
        var reverse: [Int] = []
        if !location.isEmpty {
            reverse = location.reversed()
            for index in reverse {
                var number = 0
                for road in roads {
                    if road.position == index {
                        number += 1
                        if number == 2 {
                            return index
                        }
                    }
                }
            }
        }
        return 0
    }
    
    // next location
    func next(position: Int, roads: [Road]) -> Int {
        if !roads.isEmpty {
            let size = roads.count - 1
            for i in 0...size {
                if roads[i].position == position && size > i {
                    return roads[i].next
                }
            }
        }
        return 0
    }
    
    // remove
    func remove(postion: Int, next: Int, roads: inout [Road]) {
        if next != 0 {
            let size = roads.count - 1
            for i in 0...size {
                if roads[i].position == postion && roads[i].next == next {
                    print("remove roads[i]: ", roads.remove(at: i))
                    break
                }
            }
        }
    }
    
    func find(roads: inout [Road], solution: inout Return) -> Void {
        var total = 0
        var current = 0
        var locations: [Int] = [0]
        let size = roads.count - 1
        for i in 0...size {
            if current == roads[i].position {
                current = roads[i].next
                locations.append(current)
                total += roads[i].lengh
            }
        }
        print("positions: ", locations)
        print("total: ", total)
        if solution.lengh == 0 || solution.lengh > total {
            if locations.last == 15 {
                solution = (locations, total)
            }
        }
        let option = self.brand(location: locations, roads: roads)
        let point = self.next(position: option, roads: roads)
        self.remove(postion: option, next: point, roads: &roads)
        if !roads.isEmpty && roads[0].position == 0 {
            find(roads: &roads, solution: &solution)
        }
        self.solution = solution
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
