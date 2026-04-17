// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BlockchainMCQ {

    // 1️⃣ Questions array
    string[10] public questions = [
        "What is blockchain?",
        "Who invented blockchain?",
        "What is a smart contract?",
        "Which blockchain introduced smart contracts?",
        "What is the native cryptocurrency of Ethereum?",
        "What does a block contain?",
        "Which consensus mechanism is used by Bitcoin?",
        "What is gas in Ethereum?",
        "What is a public blockchain?",
        "What does decentralization mean?"
    ];

    // 2️⃣ Options array (each question has 4 options)
    string[][] public options = [
        ["Distributed Ledger","Centralized DB", "Cloud Storage", "Web Server"],
        ["Elon Musk", "Satoshi Nakamoto", "Vitalik Buterin", "Mark Zuckerberg"],
        ["Legal document", "Self-executing code", "Website", "Database"],
        ["Bitcoin", "Ethereum", "Litecoin", "Dogecoin"],
        ["BTC", "ETH", "BNB", "SOL"],
        ["Only data", "Only hash", "Data, hash, previous hash", "Only transactions"],
        ["Proof of Stake", "Proof of Authority", "Proof of Work", "Delegated PoS"],
        ["Reward","Mining hardware", "Storage",  "Transaction fee"],
        ["Private network", "Permissioned network", "Open to everyone", "Company owned"],
        ["Single authority", "Multiple authorities", "No central authority", "Government control"]
    ];

    // 3️⃣ Correct answers array (option number: 1–4)
    uint[] public correctAnswers = [
        1, // Distributed Ledger 1
        2, // Satoshi Nakamoto 2
        2, // Self-executing code 3
        2, // Ethereum 4 
        2, // ETH 5 
        3, // Data, hash, previous hash 6
        3, // Proof of Work 7
        4, // Transaction fee 8
        3, // Open to everyone 9
        3  // No central authority 10
    ];

    function checkAnswer(uint questionIndex, uint selectedOption) public view returns (bool)
    {
        require(questionIndex < questions.length, "Invalid question index");
        require(selectedOption >= 1 && selectedOption <= 4, "Option must be 1 to 4");

        return correctAnswers[questionIndex] == selectedOption;
    }
    

    function checkFullQuiz(uint[] memory userAnswers) public view returns (uint score)
    {
    // STEP 1: Ensure user answered all questions
        require(userAnswers.length == correctAnswers.length, "All questions must be answered");
            
    // STEP 2: Initialize score counter
        score = 0;

    // STEP 3: Loop through each question
        for (uint i = 0; i < correctAnswers.length; i++) {

    // STEP 4: Compare user's answer with correct answer
            if (userAnswers[i] == correctAnswers[i]) {

    // STEP 5: Increase score for correct answer
                score++;
            }
    // else → do nothing (wrong answer)
        }

        // STEP 6: Return final score
        return score;
    }

}
