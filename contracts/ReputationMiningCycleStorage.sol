/*
  This file is part of The Colony Network.

  The Colony Network is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  The Colony Network is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.
 
  You should have received a copy of the GNU General Public License
  along with The Colony Network. If not, see <http://www.gnu.org/licenses/>.
*/

pragma solidity ^0.4.23;
pragma experimental "v0.5.0";

import "../lib/dappsys/auth.sol";
import "./ReputationMiningCycleDataTypes.sol";


contract ReputationMiningCycleStorage is ReputationMiningCycleDataTypes, DSAuth {
  // Address of the Resolver contract used by EtherRouter for lookups and routing
  address resolver;

  ReputationLogEntry[] reputationUpdateLog;
  address colonyNetworkAddress;
  address tokenLockingAddress;
  address clnyTokenAddress;

  mapping (bytes32 => mapping( uint256 => mapping( bytes32 => address[]))) submittedHashes;
  mapping (address => Submission) reputationHashSubmissions;
  uint256 reputationMiningWindowOpenTimestamp;
  mapping (uint256 => Submission[]) disputeRounds;

  // Tracks the number of submissions in each round that have completed their challenge, one way or the other.
  // This might be that they passed the challenge, it might be that their opponent passed (and therefore by implication,
  // they failed), or it might be that they timed out
  mapping (uint256 => uint256) nHashesCompletedChallengeRound;
  // A flaw with this is that if someone spams lots of nonsense transactions, then 'good' users still have to come along and
  // explicitly complete the pairings. But if they get the tokens that were staked in order to make the submission, maybe
  // that's okay...?

  // Number of unique hashes submitted
  uint256 nSubmittedHashes = 0;
  uint256 nInvalidatedHashes = 0;

  // Records for which hashes, for which addresses, for which JRHs, for which entries have been accepted
  // Otherwise, people could keep submitting the same entry.
  mapping (bytes32 => mapping(address => mapping(bytes32 => mapping(uint256 => bool)))) submittedEntries;

  int256 constant MAX_INT128 = 2**127 - 1;
  int256 constant MIN_INT128 = (2**127)*(-1);
}
