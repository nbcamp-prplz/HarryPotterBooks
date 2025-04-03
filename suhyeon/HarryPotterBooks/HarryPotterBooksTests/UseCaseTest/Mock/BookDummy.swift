//
//  BookDummy.swift
//  HarryPotterBooksTests
//
//  Created by 이수현 on 4/2/25.
//

import Foundation
@testable import HarryPotterBooks

extension Book {
    static func dummy() -> [Book] {
        return [
            Book(
                title: "Harry Potter and the Philosopher's Stone",
                author: "J. K. Rowling",
                pages: 223,
                releaseDate: "1997-06-26",
                dedication: "For Jessica, who loves stories, for Anne, who loved them too, and for Di, who heard this one first",
                summary: """
                Harry Potter has never even heard of Hogwarts when the letters start dropping on the doormat at number four, Privet Drive. 
                Addressed in green ink on yellowish parchment with a purple seal, they are swiftly confiscated by his grisly aunt and uncle. 
                Then, on Harry's eleventh birthday, a great beetle-eyed giant of a man called Rubeus Hagrid bursts in with some astonishing news: 
                Harry Potter is a wizard, and he has a place at Hogwarts School of Witchcraft and Wizardry. An incredible adventure is about to begin!
                """,
                wiki: "https://harrypotter.fandom.com/wiki/Harry_Potter_and_the_Philosopher's_Stone",
                chapters: [
                    Chapter(title: "1. The Boy Who Lived"),
                    Chapter(title: "2. The Vanishing Glass"),
                    Chapter(title: "3. The Letter from No One"),
                    Chapter(title: "4. The Keeper of the Keys"),
                    Chapter(title: "5. Diagon Alley"),
                    Chapter(title: "6. The Journey from Platform Nine and Three-Quarters"),
                    Chapter(title: "7. The Sorting Hat"),
                    Chapter(title: "8. The Potions Master"),
                    Chapter(title: "9. The Midnight Duel"),
                    Chapter(title: "10. Hallowe'en"),
                    Chapter(title: "11. Quidditch"),
                    Chapter(title: "12. The Mirror of Erised"),
                    Chapter(title: "13. Nicolas Flamel"),
                    Chapter(title: "14. Norbert the Norwegian Ridgeback"),
                    Chapter(title: "15. The Forbidden Forest"),
                    Chapter(title: "16. Through the Trapdoor"),
                    Chapter(title: "17. The Man with Two Faces")
                ]
            ),
            Book(
                title: "Harry Potter and the Chamber of Secrets",
                author: "J. K. Rowling",
                pages: 251,
                releaseDate: "1998-07-02",
                dedication: "For Séan P. F. Harris, getaway driver and foul-weather friend",
                summary: """
                Harry Potter's summer has included the worst birthday ever, doomy warnings from a house-elf called Dobby, 
                and rescue from the Dursleys by his friend Ron Weasley in a magical flying car! Back at Hogwarts School of Witchcraft 
                And Wizardry for his second year, Harry hears strange whispers echo through empty corridors – and then the attacks start. 
                Students are found as though turned to stone... Dobby's sinister predictions seem to be coming true.
                """,
                wiki: "https://harrypotter.fandom.com/wiki/Harry_Potter_and_the_Chamber_of_Secrets",
                chapters: [
                    Chapter(title: "1. The Worst Birthday"),
                    Chapter(title: "2. Dobby's Warning"),
                    Chapter(title: "3. The Burrow"),
                    Chapter(title: "4. At Flourish and Blotts"),
                    Chapter(title: "5. The Whomping Willow"),
                    Chapter(title: "6. Gilderoy Lockhart"),
                    Chapter(title: "7. Mudbloods And Murmurs"),
                    Chapter(title: "8. The Deathday Party"),
                    Chapter(title: "9. The Writing on the Wall"),
                    Chapter(title: "10. The Rogue Bludger"),
                    Chapter(title: "11. The Duelling Club"),
                    Chapter(title: "12. The Polyjuice Potion"),
                    Chapter(title: "13. The Very Secret Diary"),
                    Chapter(title: "14. Cornelius Fudge"),
                    Chapter(title: "15. Aragog"),
                    Chapter(title: "16. The Chamber of Secrets"),
                    Chapter(title: "17. The Heir of Slytherin"),
                    Chapter(title: "18. Dobby's Reward")
                ]
            ),
            Book(
                title: "Harry Potter and the Prisoner of Azkaban",
                author: "J. K. Rowling",
                pages: 317,
                releaseDate: "1999-07-08",
                dedication: "To Jill Prewett and Aine Kiely, the Godmothers of Swing",
                summary: """
                When the Knight Bus crashes through the darkness and screeches to a halt in front of him, 
                it's the start of another far from ordinary year at Hogwarts for Harry Potter. Sirius Black, 
                escaped mass-murderer and follower of Lord Voldemort, is on the run – and they say he is coming after Harry. 
                In his first ever Divination class, Professor Trelawney sees an omen of death in Harry's tea leaves... 
                But perhaps most terrifying of all are the Dementors patrolling the school grounds, with their soul-sucking kiss.
                """,
                wiki: "https://harrypotter.fandom.com/wiki/Harry_Potter_and_the_Prisoner_of_Azkaban",
                chapters: [
                    Chapter(title: "1. Owl Post"),
                    Chapter(title: "2. Aunt Marge's Big Mistake"),
                    Chapter(title: "3. The Knight Bus"),
                    Chapter(title: "4. The Leaky Cauldron"),
                    Chapter(title: "5. The Dementor"),
                    Chapter(title: "6. Talons and Tea Leaves"),
                    Chapter(title: "7. The Boggart in the Wardrobe"),
                    Chapter(title: "8. Flight of the Fat Lady"),
                    Chapter(title: "9. Grim Defeat"),
                    Chapter(title: "10. The Marauder's Map"),
                    Chapter(title: "11. The Firebolt"),
                    Chapter(title: "12. The Patronus"),
                    Chapter(title: "13. Gryffindor versus Ravenclaw"),
                    Chapter(title: "14. Snape's Grudge"),
                    Chapter(title: "15. The Quidditch Final"),
                    Chapter(title: "16. Professor Trelawney's Prediction"),
                    Chapter(title: "17. Cat, Rat and Dog"),
                    Chapter(title: "18. Moony, Wormtail, Padfoot and Prongs"),
                    Chapter(title: "19. The Servant of Lord Voldemort"),
                    Chapter(title: "20. The Dementor's Kiss"),
                    Chapter(title: "21. Hermione's Secret"),
                    Chapter(title: "22. Owl Post Again")
                ]
            )
        ]
    }
}
