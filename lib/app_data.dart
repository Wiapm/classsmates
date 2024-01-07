// ignore_for_file: unnecessary_const

import './models/category.dart';
import 'models/document.dart';

const Categories_data = const [
  Category(
    id: 'c1',
    title: 'Chimie',
    imageUrl: 'images/chimie.jpg',
  ),
  Category(
    id: 'c2',
    title: 'Math',
    imageUrl: 'images/Math.jpg',
  ),
  Category(
    id: 'c3',
    title: 'SVT',
    imageUrl: 'images/Svt.jpg',
  ),
  Category(
    id: 'c4',
    title: '..Histoire',
    imageUrl: 'images/histoire.jpg',
  ),
  Category(
    id: 'c5',
    title: 'Electricité',
    imageUrl: 'images/ele.jpg',
  ),
  Category(
    id: 'c6',
    title: 'info',
    imageUrl: 'images/programmation.jpg',
  ),
];

const Trips_data = [
  Trip(
    '1',
    ['c1'],
    ' ',
    'images/ch1.jpg',
    ['Hiking', 'Climbing'],
    [
      'Day 1: Arrival and acclimatization',
      'Day 2: Trek to base camp',
      'Day 3-6: Summit attempts',
      'Day 7: Descend to base camp',
      'Day 8: Return to civilization'
    ],
    5,
    'Winter',
    TripType.Exploration,
    false,
    true,
    false,
  ),
  Trip(
    '3',
    ['c1'],
    ' ',
    'images/ch3.png',
    ['Hiking', 'Climbing'],
    [
      'Day 1: Arrival and acclimatization',
      'Day 2: Trek to base camp',
      'Day 3-6: Summit attempts',
      'Day 7: Descend to base camp',
      'Day 8: Return to civilization'
    ],
    9,
    'Winter',
    TripType.Exploration,
    false,
    true,
    false,
  ),
  Trip(
    '1',
    ['c2'],
    ' ',
    'images/d2.jpg',
    ['Hiking', 'Climbing'],
    [
      'Day 1: Arrival and acclimatization',
      'Day 2: Trek to base camp',
      'Day 3-6: Summit attempts',
      'Day 7: Descend to base camp',
      'Day 8: Return to civilization'
    ],
    8,
    'Winter',
    TripType.Exploration,
    false,
    true,
    false,
  ),
  Trip(
    '2',
    ['c2'],
    ' ',
    'images/d5.png',
    ['Hiking', 'Climbing'],
    [
      'Day 1: Arrival and acclimatization',
      'Day 2: Trek to base camp',
      'Day 3-6: Summit attempts',
      'Day 7: Descend to base camp',
      'Day 8: Return to civilization'
    ],
    4,
    'Winter',
    TripType.Exploration,
    false,
    true,
    false,
  ),
  Trip(
    '3',
    ['c2'],
    ' ',
    'images/d1.png',
    ['Hiking', 'Climbing'],
    [
      'Day 1: Arrival and acclimatization',
      'Day 2: Trek to base camp',
      'Day 3-6: Summit attempts',
      'Day 7: Descend to base camp',
      'Day 8: Return to civilization'
    ],
    4,
    'Winter',
    TripType.Exploration,
    false,
    true,
    false,
  ),
  Trip(
    '2',
    ['c2'],
    ' ',
    'images/d3.jpg',
    ['Hiking', 'Climbing'],
    [
      'Day 1: Arrival and acclimatization',
      'Day 2: Trek to base camp',
      'Day 3-6: Summit attempts',
      'Day 7: Descend to base camp',
      'Day 8: Return to civilization'
    ],
    4,
    'Winter',
    TripType.Exploration,
    false,
    true,
    false,
  ),
];
