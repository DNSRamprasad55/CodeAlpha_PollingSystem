# CodeAlpha Polling System Smart Contract

## Description
A blockchain based polling system created using Solidity.

## Features

- Create polls with title and options
- Set voting deadline
- Users can vote only once
- Prevent duplicate voting using mappings
- Time based voting restriction
- Automatically determine winner after poll ends

## Technology Used

- Solidity
- Ethereum Blockchain
- Remix IDE

## Smart Contract Functions

createPoll()
- Creates a new poll

vote()
- Allows users to vote

getPoll()
- Shows poll information

getWinner()
- Returns winning option after poll completion


## Testing

Successfully tested:
- Poll creation
- Voting
- Duplicate vote prevention
- Deadline restriction
- Winner calculation
