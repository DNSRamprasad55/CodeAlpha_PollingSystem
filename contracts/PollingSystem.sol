// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;


/*
 CodeAlpha Task 3
 Polling System Smart Contract
*/

contract PollingSystem {


    struct Poll {

        string title;

        string[] options;

        uint endTime;

        mapping(uint => uint) voteCount;

        mapping(address => bool) hasVoted;

        bool exists;
    }


    uint public pollCounter;


    mapping(uint => Poll) private polls;


    // Create a new poll

    function createPoll(
        string memory _title,
        string[] memory _options,
        uint _durationInMinutes
    )
        public
    {

        require(
            _options.length > 1,
            "Need minimum two options"
        );


        pollCounter++;


        Poll storage newPoll = polls[pollCounter];


        newPoll.title = _title;

        newPoll.options = _options;

        newPoll.endTime =
            block.timestamp + (_durationInMinutes * 1 minutes);

        newPoll.exists = true;
    }




    // Vote function

    function vote(
        uint _pollId,
        uint _optionIndex
    )
        public
    {

        Poll storage selectedPoll = polls[_pollId];


        require(
            selectedPoll.exists,
            "Poll not found"
        );


        require(
            block.timestamp < selectedPoll.endTime,
            "Voting ended"
        );


        require(
            selectedPoll.hasVoted[msg.sender] == false,
            "Already voted"
        );


        require(
            _optionIndex < selectedPoll.options.length,
            "Invalid option"
        );



        selectedPoll.voteCount[_optionIndex]++;


        selectedPoll.hasVoted[msg.sender] = true;

    }



    // Get poll information

    function getPoll(
        uint _pollId
    )
        public
        view
        returns(
            string memory,
            string[] memory,
            uint
        )
    {

        Poll storage selectedPoll = polls[_pollId];


        return(
            selectedPoll.title,
            selectedPoll.options,
            selectedPoll.endTime
        );

    }




    // Get winner after poll ends

    function getWinner(
        uint _pollId
    )
        public
        view
        returns(string memory)
    {

        Poll storage selectedPoll = polls[_pollId];


        require(
            block.timestamp >= selectedPoll.endTime,
            "Poll still running"
        );



        uint highestVotes = 0;

        uint winnerIndex = 0;



        for(
            uint i = 0;
            i < selectedPoll.options.length;
            i++
        )

        {

            if(
                selectedPoll.voteCount[i] > highestVotes
            )

            {

                highestVotes =
                selectedPoll.voteCount[i];


                winnerIndex = i;
            }

        }



        return selectedPoll.options[winnerIndex];

    }


}