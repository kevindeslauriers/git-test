#!/bin/bash

#just a comment

# Function to list available subjects
list_subjects() {
    echo "Available subjects/projects:"
    ls ~/personal_organizer
}

# Function to select a subject
select_subject() {
    echo "Please select a subject/project:"
    read subject
    if [ -d "$HOME/personal_organizer/$subject" ]; then
        echo "Subject selected: $subject"
    else
        echo "Subject not found. Please ensure the subject exists."
        subject=""
    fi
}

# Function to create a new subject/project directory
create_subject() {
    echo "Enter the name of the new subject or project:"
    read subject
    mkdir -p "$HOME/personal_organizer/$subject"
    echo "Folder for $subject created."
}

# Function to add a note to the subject
add_note() {
    select_subject
    if [ -n "$subject" ]; then
        echo "Enter your note:"
        read note
        echo "$note" >> "$HOME/personal_organizer/$subject/notes.txt"
        echo "Note added to $subject."
    fi
}

# Function to view notes
view_notes() {
    select_subject
    if [ -f "$HOME/personal_organizer/$subject/notes.txt" ]; then
        cat "$HOME/personal_organizer/$subject/notes.txt"
    else
        echo "No notes found for $subject."
    fi
}

# Function to search notes
search_notes() {
    select_subject
    if [ -f "$HOME/personal_organizer/$subject/notes.txt" ]; then
        echo "Enter the keyword to search:"
        read keyword
        grep "$keyword" "$HOME/personal_organizer/$subject/notes.txt"
    else
        echo "No notes found for $subject."
    fi
}

# Function to archive notes
archive_notes() {
    select_subject
    if [ -f "$HOME/personal_organizer/$subject/notes.txt" ]; then
        tar -czvf "$HOME/personal_organizer/$subject/notes_archive.tar.gz" "$HOME/personal_organizer/$subject/notes.txt"
        rm "$HOME/personal_organizer/$subject/notes.txt"
        echo "Notes for $subject archived and removed."
    else
        echo "No notes to archive for $subject."
    fi
}

# Main Menu
while true; do
    echo "------------------------"
    echo "Personal Organizer Menu:"
    echo "1. Create a new subject/project"
    echo "2. Add a note"
    echo "3. View notes"
    echo "4. Search notes"
    echo "5. Archive notes"
    echo "6. Exit"
    echo "------------------------"
    echo "Choose an option:"
    read option

    case $option in
        1) 
            create_subject
            ;;
        2)
            list_subjects
            add_note
            ;;
        3)
            list_subjects
            view_notes
            ;;
        4)
            list_subjects
            search_notes
            ;;
        5)
            list_subjects
            archive_notes
            ;;
        6)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option, please try again!"
            ;;
    esac
done
