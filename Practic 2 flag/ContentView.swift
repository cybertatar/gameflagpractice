//
//  ContentView.swift
//  Practic 2 flag
//
//  Created by Даниил Тынчеров on 28.08.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["UK", "USA", "Bangladesh", "Brazil", "Russia", "Germany", "Argentina", "Greece", "Sweden", "Canada"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.black, .white]), startPoint: .top, endPoint: .bottom) //тут мы создали градиент
                .edgesIgnoringSafeArea(.all) //тут мы сделали так, что градиент заливает весь фон вместе с шапкой
            VStack(spacing: 30) {
            VStack{
                Text("Выбери флаг:")
                    .foregroundColor(.white)
                    .font(.headline)
                Text(countries[correctAnswer])
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.black)
                
            }
                ForEach (0..<3) { number in
                    Button(action: {
                        self.flagTapped(number)
                        self.showingScore = true
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .frame(width: 250, height: 115)
                            .clipShape(Capsule()) //помещаем флажки в овалы
                            .overlay(Capsule().stroke(Color.black, lineWidth: 3))
                            .shadow(color: .black, radius: 2) //добавляем тени для контура флажков
                        
                    }
                }
                Text("Общий счёт: \(score)")
                    .font(.largeTitle)
                    .fontWeight(.black)
                Spacer()
        }
    
    }
        .alert(isPresented: $showingScore){
            Alert(title: Text(scoreTitle), message: Text("Общий счёт: \(score)"), dismissButton: .default(Text("Продолжить")) {
                self.askQuestion()
            })
        }
    }
        func askQuestion() {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
        func flagTapped (_ number: Int) {
            if number == correctAnswer {
                scoreTitle = "Правильный ответ!"
                score += 1
            } else {
                scoreTitle = "Неправильно! Правильный ответ \(countries[number])"
                score -= 1
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
