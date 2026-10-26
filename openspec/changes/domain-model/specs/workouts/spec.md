# Spec Delta

## Purpose

Defines a workout as a named, ordered list of interval phases, and how a workout converts to and from JSON for storage.

## ADDED Requirements

### Requirement: Interval phase holds type, duration, and label
An interval phase SHALL have a type, a duration, and an optional label. The type SHALL be one of `warmup`, `work`, `rest`, or `cooldown`.

#### Scenario: Phase with a label
- **WHEN** a phase is created with type `work`, a duration of 30 seconds, and the label "Squats"
- **THEN** the phase has type `work`, a duration of 30 seconds, and the label "Squats"

#### Scenario: Phase without a label
- **WHEN** a phase is created with type `rest` and a duration of 10 seconds, and no label
- **THEN** the phase has no label

### Requirement: Phase duration is a positive whole number of seconds
The system SHALL reject an interval phase whose duration is zero, negative, or not a whole number of seconds.

#### Scenario: Zero duration
- **WHEN** a phase is created with a duration of 0 seconds
- **THEN** the system rejects it with an argument error

#### Scenario: Negative duration
- **WHEN** a phase is created with a duration of -5 seconds
- **THEN** the system rejects it with an argument error

#### Scenario: Duration with a fraction of a second
- **WHEN** a phase is created with a duration of 1500 milliseconds
- **THEN** the system rejects it with an argument error

### Requirement: Workout holds an id, a name, and ordered phases
A workout SHALL have an id, a name, and an ordered list of interval phases. The order of the phases SHALL be the order in which they run.

#### Scenario: Phases keep their order
- **WHEN** a workout is created with the phases warmup, work, rest, cooldown in that order
- **THEN** the workout returns the phases in the same order

### Requirement: Workout has at least one phase
The system SHALL reject a workout with an empty list of phases.

#### Scenario: Empty phase list
- **WHEN** a workout is created with no phases
- **THEN** the system rejects it with an argument error

### Requirement: New workout gets a unique id
When a new workout is created without an id, the system SHALL give it a random UUID (version 4).

#### Scenario: Two new workouts
- **WHEN** two new workouts are created without an id
- **THEN** each workout has a valid version 4 UUID, and the two ids are different

### Requirement: Workout and phase are immutable values
Workouts and phases SHALL NOT change after creation. Two instances with equal fields SHALL be equal. A copy with changed fields SHALL leave the original unchanged.

#### Scenario: Equal fields
- **WHEN** two phases are created with the same type, duration, and label
- **THEN** the two phases are equal and have the same hash code

#### Scenario: Copy with a new name
- **WHEN** a workout is copied with a new name
- **THEN** the copy has the new name and the same id and phases, and the original keeps its old name

#### Scenario: Phase list cannot change
- **WHEN** code tries to add a phase to the phase list of an existing workout
- **THEN** the system throws an unsupported operation error

### Requirement: Workout converts to and from JSON
The system SHALL convert a workout to a JSON object and back to an equal workout. The JSON SHALL use the keys `id`, `name`, and `phases`. Each phase SHALL use the keys `type` (the type name as a string), `durationSeconds` (an integer), and `label` (a string or null).

#### Scenario: Round trip
- **WHEN** a workout with three phases is converted to JSON and back
- **THEN** the result equals the original workout

#### Scenario: JSON shape of a phase
- **WHEN** a `work` phase of 30 seconds with the label "Squats" is converted to JSON
- **THEN** the result is `{"type": "work", "durationSeconds": 30, "label": "Squats"}`

### Requirement: Invalid workout JSON is rejected
The system SHALL reject workout JSON with a missing required key or an unknown phase type. It SHALL also reject JSON values that break a phase or workout rule.

#### Scenario: Unknown phase type
- **WHEN** JSON with the phase type `"sprint"` is read
- **THEN** the system rejects it with an error

#### Scenario: Missing name
- **WHEN** workout JSON without the key `name` is read
- **THEN** the system rejects it with an error

#### Scenario: Zero duration in JSON
- **WHEN** JSON with `"durationSeconds": 0` is read
- **THEN** the system rejects it with an argument error
