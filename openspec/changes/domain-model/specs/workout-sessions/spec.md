# Spec Delta

## Purpose

Records one run of a workout with its start and end time, and defines how a session converts to and from JSON for storage.

## ADDED Requirements

### Requirement: Session records one run of a workout
A workout session SHALL have an id, the id of the workout it runs, a start time, and an optional end time. A session without an end time is not complete.

#### Scenario: Started session
- **WHEN** a session is created with a workout id and a start time, and no end time
- **THEN** the session has that workout id and start time, and it is not complete

#### Scenario: Completed session
- **WHEN** a session is created with a start time and an end time
- **THEN** the session is complete

### Requirement: End time is not before start time
The system SHALL reject a session whose end time is before its start time.

#### Scenario: End before start
- **WHEN** a session is created with an end time one second before its start time
- **THEN** the system rejects it with an argument error

#### Scenario: End equals start
- **WHEN** a session is created with an end time equal to its start time
- **THEN** the system accepts it

### Requirement: Session times are stored in UTC
The system SHALL store the start time and the end time of a session in UTC.

#### Scenario: Local time input
- **WHEN** a session is created with a local start time
- **THEN** the session start time is in UTC and is the same moment as the input

### Requirement: New session gets a unique id
When a new session is created without an id, the system SHALL give it a random UUID (version 4).

#### Scenario: Two new sessions
- **WHEN** two new sessions are created without an id
- **THEN** each session has a valid version 4 UUID, and the two ids are different

### Requirement: Session is an immutable value
A session SHALL NOT change after creation. Two sessions with equal fields SHALL be equal. A copy with changed fields SHALL leave the original unchanged.

#### Scenario: Complete a session by copy
- **WHEN** a session without an end time is copied with an end time
- **THEN** the copy is complete, and the original is still not complete

#### Scenario: Equal fields
- **WHEN** two sessions are created with the same fields
- **THEN** the two sessions are equal and have the same hash code

### Requirement: Session converts to and from JSON
The system SHALL convert a session to a JSON object and back to an equal session. The JSON SHALL use the keys `id`, `workoutId`, `startedAt`, and `completedAt`. Times SHALL be ISO 8601 strings in UTC. A missing end time SHALL be `null`.

#### Scenario: Round trip
- **WHEN** a completed session is converted to JSON and back
- **THEN** the result equals the original session

#### Scenario: JSON shape of a started session
- **WHEN** a session that started at 2026-10-26 08:00:00 UTC, with no end time, is converted to JSON
- **THEN** `startedAt` is `"2026-10-26T08:00:00.000Z"` and `completedAt` is `null`

### Requirement: Invalid session JSON is rejected
The system SHALL reject session JSON with a missing required key or a time that is not a valid ISO 8601 string. It SHALL also reject an end time before the start time.

#### Scenario: Missing workout id
- **WHEN** session JSON without the key `workoutId` is read
- **THEN** the system rejects it with an error

#### Scenario: Invalid time
- **WHEN** session JSON with `"startedAt": "yesterday"` is read
- **THEN** the system rejects it with an error
