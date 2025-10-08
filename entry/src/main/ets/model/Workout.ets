export interface SetEntry {
  reps: number;
  weightKg: number;
}

export interface Exercise {
  id: string;
  name: string;
  sets: SetEntry[];
}

export interface Workout {
  id: string;
  title: string;
  bodyPart: 'Chest' | 'Back' | 'Legs' | 'Shoulders';
  exercises: Exercise[];
  lastPerformedAt?: string;
}

export const sampleWorkouts: Workout[] = [
  {
    id: 'w_chest',
    title: 'Chest Workout',
    bodyPart: 'Chest',
    lastPerformedAt: '2025-09-25T18:30:00Z',
    exercises: [
      { id: 'e_bp', name: 'Barbell Bench Press', sets: [{ reps: 10, weightKg: 60 }, { reps: 8, weightKg: 70 }] },
      { id: 'e_dip', name: 'Weighted Dips', sets: [{ reps: 8, weightKg: 10 }] },
      { id: 'e_fly', name: 'Cable Fly', sets: [{ reps: 12, weightKg: 15 }] }
    ]
  },
  {
    id: 'w_back',
    title: 'Back Workout',
    bodyPart: 'Back',
    lastPerformedAt: '2025-09-24T19:00:00Z',
    exercises: [
      { id: 'e_row', name: 'Seated Row', sets: [{ reps: 10, weightKg: 55 }] },
      { id: 'e_lat', name: 'Lat Pulldown', sets: [{ reps: 8, weightKg: 65 }] },
      { id: 'e_dl', name: 'Romanian Deadlift', sets: [{ reps: 8, weightKg: 80 }] }
    ]
  },
  {
    id: 'w_legs',
    title: 'Legs Workout',
    bodyPart: 'Legs',
    exercises: [
      { id: 'e_sq', name: 'Back Squat', sets: [{ reps: 5, weightKg: 90 }] },
      { id: 'e_lp', name: 'Leg Press', sets: [{ reps: 12, weightKg: 160 }] },
      { id: 'e_calf', name: 'Standing Calf Raise', sets: [{ reps: 15, weightKg: 40 }] }
    ]
  },
  {
    id: 'w_shoulders',
    title: 'Shoulders Workout',
    bodyPart: 'Shoulders',
    exercises: [
      { id: 'e_ohp', name: 'Dumbbell Shoulder Press', sets: [{ reps: 10, weightKg: 20 }] },
      { id: 'e_lat', name: 'Cable Lateral Raise', sets: [{ reps: 12, weightKg: 5 }] },
      { id: 'e_rev', name: 'Rear Delt Fly', sets: [{ reps: 12, weightKg: 5 }] }
    ]
  }
];
